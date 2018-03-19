# Surf with Capybara. Fill in forms, clicks by the site navigation, etc.

require 'selenium-webdriver'
require 'capybara'

def browser(query, location)
  browser = Capybara.current_session
  driver = browser.driver.browser
    browser.visit('https://www.olx.ua')
    browser.find('#cookiesBar .close').click if browser.has_css?('#cookiesBar')
    browser.find('#headerSearch').click
    browser.find('#headerSearch').set(query)
    browser.find('#cityField').click
    browser.find('#cityField').set(location)
    browser.find('#submit-searchmain').click
    browser.find('#submit-searchmain').click
    abort 'Nothing found!' if browser.has_content?('Не найдено ни одного объявления, соответствующего параметрам поиска.')
  return [browser, driver]
end