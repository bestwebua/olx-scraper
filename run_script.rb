require_relative 'scraper'

scraper = Scraper.new('your search request', 'location')
scraper.browser
scraper.pagination_parser
scraper.data_graber
scraper.save