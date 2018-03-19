# Get URL stucture from results pagination if it exists.

require 'selenium-webdriver'
require 'capybara'

def pagination_parser(browser)
  if browser.has_css?('.pager')
    urls = browser.all('.container .pager a').map do |i|
      [i[:href][/.+?page=/], i[:href][/(.+?\?page)=?(\d+)/,2].to_i]
    end
    url, url_id = urls.max
  else
    url = browser.current_url + '?page='
    url_id = 1
  end
  return [url, url_id]
end