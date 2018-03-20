require_relative '../scraper'

describe Scraper do

  it 'instance of class Scraper' do
    scraper = Scraper.new('query', 'location')
    expect(scraper).to be_an_instance_of(Scraper)
  end

  it 'should raise an ArgumentError error if no parameters passed' do
    expect { Scraper.new }.to raise_error(ArgumentError)
  end

 it '#ready should use SystemExit if nothing found' do
    scraper = Scraper.new('ruby junior программист', 'Днепр')
    expect { scraper.browser }.to raise_error(SystemExit)
  end

  it '#ready should return false if class instance did not use #browser method' do
    expect(Scraper.new('жена на час', 'Днепр').ready).to eq(false)
  end

  it '#ready should return true if something found' do
    scraper = Scraper.new('жена на час', 'Днепр')
    scraper.browser
    expect(scraper.ready).to eq(true)
  end

  it '#pagination_parser should raise an error if instance method #ready return false' do
    scraper = Scraper.new('жена на час', 'Днепр')
    expect { scraper.pagination_parser }.to raise_error(RuntimeError)
  end

  it '#url_id should equal 1 if instance method #pagination_parser found no pagination' do
    scraper = Scraper.new('жена на час', 'Днепр')
    scraper.browser
    scraper.pagination_parser
    expect(scraper.url_id).to eq(1)
  end

  it '#url_id should be more than 1 if instance method #pagination_parser found pagination' do
    scraper = Scraper.new('котики', 'Днепр')
    scraper.browser
    scraper.pagination_parser
    expect(scraper.url_id).to be > 1
  end

  it '#data_graber should raise an error if instance method #ready return false' do
    scraper = Scraper.new('жена на час', 'Днепр')
    expect { scraper.data_graber }.to raise_error(RuntimeError)
  end

  it '#grab_data should be not empty if instance method #data_graber has collected data' do
    scraper = Scraper.new('жена на час', 'Днепр')
    scraper.browser
    scraper.pagination_parser
    scraper.data_graber
    expect(scraper.grab_data.empty?).to eq(false)
  end

  it '#save should raise an error if instance method #grab_data is empty' do
    scraper = Scraper.new('жена на час', 'Днепр')
    expect { scraper.save }.to raise_error(RuntimeError)
  end

  describe '#save should create data.txt file and save all collected data to it' do

    scraper = Scraper.new('жена на час', 'Днепр')
    scraper.browser
    scraper.pagination_parser
    scraper.data_graber
    scraper.save
    file = "#{File.expand_path('../.', File.dirname(__FILE__))}/data.txt"

    it '#save should create a new file data.txt' do
      expect(File.exist?(file)).to eq(true)
    end

    it '#save should save all collected data to data.txt' do
      expect(File.zero?(file)).to eq(false)
      File.delete(file)
    end
  end

end