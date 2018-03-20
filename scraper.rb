require 'selenium-webdriver'
require 'capybara'
require 'nokogiri'
require 'json'
require_relative 'config'

class Scraper

  attr_reader :ready, :url, :url_id, :grab_data

  def initialize(query, location)
    @query = query
    @location = location
    @grab_data, @ready = [], false
    @page, @driver, @url, @url_id = nil
  end

  # Surf with Capybara. Fill in forms, clicks by the site navigation, etc.
  def browser
    @page = Capybara.current_session
    @driver = @page.driver.browser
    @page.visit('https://www.olx.ua')
    mandatory_items = ['#headerSearch', '#cityField', '#submit-searchmain']
      abort 'No mandatory html & css items!' if mandatory_items.all? { |item| @page.has_no_css?(item) }
      @page.find('#cookiesBar .close').click if @page.has_css?('#cookiesBar')
        @page.find('#headerSearch').click
          @page.find('#headerSearch').set(@query)
            @page.find('#cityField').click
          @page.find('#cityField').set(@location)
        2.times { @page.find('#submit-searchmain').click }
      abort 'Nothing found!' if @page.has_content?('Не найдено ни одного объявления, соответствующего параметрам поиска.')
    @ready = true
  end

  # Get URL stucture from results pagination if it exists.
  def pagination_parser
    raise "Object isn't ready to parse" unless @ready
    if @page.has_css?('.pager')
      urls = @page.all('.container .pager a').map do |i|
        [i[:href][/.+?page=/], i[:href][/(.+?\?page)=?(\d+)/,2].to_i]
      end
      url, url_id = urls.max
    else
      url = @page.current_url + '?page='
      url_id = 1
    end
    @url, @url_id = url, url_id
  end

  # Iteration by URL list from pagination and grab data with Nokogiri.
  def data_graber
    raise "Object isn't ready to parse" unless @ready
    (1...@url_id+1).map { |id| @url + id.to_s }.each do |url|
      @page.visit(url)
        current_page = Nokogiri::HTML(@driver.page_source)
        items = current_page.css('table.offers .offer > table')
      items.each do |item|
        title = item.css('h3 strong').text
        price = item.css('.price strong').text
        url = item.css('h3 a').map { |link| link['href'][/(.)+\.html/] }.first
        @grab_data << {:title => title, :price => price, :url => url}.to_json
      end
    end
  end

  # Provide to save collected data into the file.
  def save
    raise 'Nothing to save' if @grab_data.empty?
    data = File.new("#{File.expand_path(File.dirname(__FILE__))}/data.txt", 'a+')
    File.open(data, 'a+') { |data| data.puts @grab_data }
  end

end