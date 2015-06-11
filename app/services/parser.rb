require 'open-uri'

class Parser
  HEADLESS_RUN = false

  def create_apartment(**params)
    item = Apartment.create(params)
    if item.save
      puts item.inspect
    else
      puts 'mot created'
    end
  end

  def start(count=3)
    if HEADLESS_RUN
      headless = Headless.new
      headless.start
    end
    doc = Nokogiri::HTML(open('https://www.avito.ru/irkutsk/kvartiry/sdam/na_dlitelnyy_srok'));
    item_list=[]
    doc.css('h3.title a').each_with_index do |link, index|  
      break if ++index == count

      browser = Watir::Browser.new :firefox
      item = {}
      item_doc = Nokogiri::HTML(open("https://www.avito.ru#{link['href']}"));
      item[:renter] = item_doc.css('#seller').text.gsub(/\w|\s/,'')
      item[:price] = item_doc.css('.p_i_price').text.gsub(/\D/,'')
      item[:description] = item_doc.css('div#desc_text').text
      item[:city] = item_doc.css('div#map').text
      item[:address] = item_doc.css('span#toggle_map').text
      item[:id_ad] = item_doc.css('span#toggle_map').text

      begin
        browser.goto "https://m.avito.ru#{link['href']}"
      rescue Exception => msg 
        browser.close
        browser = Watir::Browser.new :firefox
        browser.goto "https://m.avito.ru#{link['href']}"
        puts msg
      end  

      puts browser.link(:class => "action-show-number").exists?
      browser.link(:class => "action-show-number").when_present.click
      phone_selector = browser.span :class => 'button-text'
      item[:phone1] = phone_selector.text
      # item_list << item
      byebug
      create_apartment(description: item[:description], renter: item[:renter], phone1: item[:phone1])
      browser.close  
      Watir::Wait.until(8) { sleep(6); true }     
    end
    headless.destroy if HEADLESS_RUN
    item_list
  end

  def initialize()
    
  end


end

