require 'open-uri'

class Parser
  HEADLESS_RUN = true
  DELAY_VAL    = 3
  AVITO_SOURCE = "https://www.avito.ru/irkutsk/kvartiry/sdam/na_dlitelnyy_srok".freeze
  class << self
    def pull_apartments
      get_avito
    end

    private
    def get_avito(count = 1)
      run do
        doc = Nokogiri::HTML(open(AVITO_SOURCE))
        doc.css('h3.title a').each_with_index do |ad, index|
          break if ++index == count
          delay if index != 0
          item_ad = Hash.new.tap do |item|
            link = ad['href']
            item_doc = Nokogiri::HTML(open(item_link_avito(link)))
            item[:renter] = item_doc.css('#seller strong').text.gsub(/\w|\s/, '')
            item[:description] = item_doc.css('div#desc_text').text
            item[:price] = item_doc.css('.p_i_price').text.gsub(/\D/, '')
            item[:city] = item_doc.css('div#map').text
            item[:address] = item_doc.css('span#toggle_map').text
            item[:id_ad] = item_doc.css('span#toggle_map').text
            item[:assets] = get_photos_avito(link)
            item[:phone1] = get_phone_avito(link)
          end         
          apartment = Apartment.create(get_apartment_params(item_ad))
        end
      end
    end

    def run(&block)
      if HEADLESS_RUN
        headless = Headless.new
        headless.start
      end

      yield

      headless.destroy if HEADLESS_RUN
    end

    def get_photos_avito(link)
      item_doc_mob = Nokogiri::HTML(open(item_link_avito(link, :mobile)))
      photo_links = item_doc_mob.css("li.photo-container img").select { |el| !el.nil? }.map { |el| "http:"+el['src']}
      photo_links += item_doc_mob.css("li > span").select { |el| !el['data-img-src'].nil? }.map { |el| "http:"+el['data-img-src']}
      photo_links.map { |photo_link| Asset.create(photo: URI.parse(photo_link)) }
    end

    def get_phone_avito (link)
      browser_init
      begin
        @browser.goto item_link_avito(link, :mobile)
      rescue Exception => msg
        browser_destroy
        browser_init
        @browser.goto item_link_avito(link, :mobile)
      end
      @browser.link(class: "action-show-number").when_present.click
      phone = @browser.span(class: 'button-text').text
      browser_destroy
      phone
    end

    def browser_init
      @browser ||= Watir::Browser.new :firefox
    end

    def browser_destroy
      @browser.close
      @browser = nil
    end

    def delay
      Watir::Wait.until(8) { sleep(DELAY_VAL); true }
    end

    def apartment_fields
      list = Apartment.column_names 
      list << "assets"
    end

    def get_apartment_params(item_params)
      item_params.reject { |key,value| !apartment_fields.include? key.to_s }
    end

    def item_link_avito(link, type = :default)
      return "https://m.avito.ru#{link}" if type == :mobile
      "https://www.avito.ru#{link}"
    end
  end
end

