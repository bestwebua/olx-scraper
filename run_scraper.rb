require_relative 'config'
require_relative 'browser'
require_relative 'pagination_parser'
require_relative 'data_grabber'
require_relative 'save_data'

query = 'жена на час'
location = 'Днепр'

browser, driver = browser(query, location)
url, url_id = pagination_parser(browser)
grab_data = data_grabber(url, url_id, browser, driver)
save_data(grab_data)