require_relative 'scraper'

scraper = Scraper.new('жена на час', 'Днепр')
scraper.browser
scraper.pagination_parser
scraper.data_grabber
scraper.save