# Iteration by URL list from pagination and grab data with Nokogiri.

require 'selenium-webdriver'
require 'capybara'
require 'nokogiri'
require 'json'

def data_grabber(url, url_id, browser, driver)
  grab_data = []
    (1...url_id+1).map { |id| url + id.to_s }.each do |url|
      browser.visit(url)
        current_page = Nokogiri::HTML(driver.page_source)
          items = current_page.css('table.offers .offer > table')
            items.each do |item|
              title = item.css('h3 strong').text
                price = item.css('.price strong').text
                  url = item.css('h3 a').map { |link| link['href'][/(.)+\.html/] }.first
                grab_data << {:title => title, :price => price, :url => url}.to_json
            end
    end
  return grab_data
end