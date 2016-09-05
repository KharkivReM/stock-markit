require 'spec_helper'

RSpec.describe 'StockMarkit::Lookup' do
  describe '#initialize' do
    it 'sets the instance symbol as an upcased symbol' do
      lookup = StockMarkit::Lookup.new(:twtr)
      expect( lookup.symbol ).to eq(:TWTR)
    end

    it 'accepts a string and converts to symbol internally' do
      lookup = StockMarkit::Lookup.new('twtr')
      expect( lookup.symbol ).to eq(:TWTR)
    end
  end

  describe '#fetch' do
    it 'fetches the stock data from the api' do
      VCR.use_cassette 'lookup/twtr' do
        lookup = StockMarkit::Lookup.new(:twtr)
        lookup.fetch
        expect( lookup.results ).to be_a(Array)
        expect( lookup.results.first ).to be_a(StockMarkit::Stock)
        expect( lookup.results.first.name ).to eq("Twitter Inc")
      end
    end

    it 'memoizes the results' do
      VCR.use_cassette 'lookup/twtr' do
        lookup = StockMarkit::Lookup.new(:twtr)
        results = lookup.fetch
        expect( lookup.fetch.equal?(results) ).to eq(true)
      end
    end
  end
end
