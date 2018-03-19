require 'spec_helper'
require 'open-uri'
require_relative '../browser'

describe 'browser' do
  
  it 'OLX should return 200' do
    expect(open('https://www.olx.ua').status).to eq(['200', 'OK'])
  end

  context 'mandatory html & css items' do
    browser = Capybara.current_session
    driver = browser.driver.browser
    browser.visit('https://www.olx.ua')

    it 'query serach field' do
      expect(browser.has_css?('#headerSearch')).to eq(true)
    end

    it 'query serach location field' do
      expect(browser.has_css?('#cityField')).to eq(true)
    end

    it 'submit button' do
      expect(browser.has_css?('#submit-searchmain')).to eq(true)
    end
  end

  it 'should raise an ArgumentError error if no parameters passed' do
    expect {browser}.to raise_error(ArgumentError)
  end

  it 'should raise an ArgumentError error if more then two parameters passed' do
    expect {browser('arg1', 'arg2', 'arg3')}.to raise_error(ArgumentError)
  end

  it 'should return array with browser and driver' do
    browser = Capybara.current_session
    driver = browser.driver.browser
    expect(browser('arg1', 'arg2')).to eq([browser, driver])
  end

  it 'method should abort if no data found' do
    browser = Capybara.current_session
    driver = browser.driver.browser
    browser.visit('https://www.olx.ua')
    query, location = 'junior ruby программист', 'днепр'

    browser.find('#headerSearch').click
      browser.find('#headerSearch').set(query)
        browser.find('#cityField').click
        browser.find('#cityField').set(location)
      browser.find('#submit-searchmain').click
    browser.find('#submit-searchmain').click

    expect { browser(query, location) }.to raise_error(SystemExit) #загвоздка
  end

end