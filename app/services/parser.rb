require 'open-uri'

class Parser
  HEADLESS_RUN = true
  DELAY_VAL    = 3
  AVITO_SOURCE = "https://www.avito.ru/irkutsk/kvartiry/sdam/na_dlitelnyy_srok".freeze

  def self.get_avito(count = 2)
    if HEADLESS_RUN
      headless = Headless.new
      headless.start
    end
    
    doc = Nokogiri::HTML(open(AVITO_SOURCE));
    
    doc.css('h3.title a').each_with_index do |ad, index|
      break if ++index == count
      delay if index != 0
      browser = browser_init
      item = {}
      link = ad['href']
      item_doc = Nokogiri::HTML(open(item_link_avito(link)));
      item[:renter] = item_doc.css('#seller strong').text.gsub(/\w|\s/,'')
      item[:description] = item_doc.css('div#desc_text').text
      item[:price] = item_doc.css('.p_i_price').text.gsub(/\D/,'')
      item[:city] = item_doc.css('div#map').text
      item[:address] = item_doc.css('span#toggle_map').text
      item[:id_ad] = item_doc.css('span#toggle_map').text
      begin
        browser.goto item_link_avito(link, :mobile)
      rescue Exception => msg
        browser.close
        browser = browser_init
        browser.goto item_link_avito(link, :mobile)
      end

      browser.link(class: "action-show-number").when_present.click
      phone_selector = browser.span class: 'button-text'
      item[:phone1] = phone_selector.text

      Apartment.create(get_apartment_params(item))
      browser.close
    end
    headless.destroy if HEADLESS_RUN
    
  end

  private
  def self.browser_init
    Watir::Browser.new :firefox
  end

  def self.delay
    Watir::Wait.until(8) { sleep(DELAY_VAL); true }
  end

  def self.get_apartment_params(item_params)
    item_params.reject { |key,value| !Apartment.column_names.include? key.to_s }
  end

  def self.item_link_avito(link, type = :default)
    return "https://m.avito.ru#{link}" if type == :mobile
    "https://www.avito.ru#{link}"
  end

end

