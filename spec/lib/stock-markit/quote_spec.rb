require 'spec_helper'

RSpec.describe 'StockMarkit::Quote' do
  describe '#initialize' do
    it 'sets the instance symbol as an upcased symbol' do
      quote = StockMarkit::Quote.new(:twtr)
      expect( quote.symbol ).to eq(:TWTR)
    end

    it 'accepts a string and converts to symbol internally' do
      quote = StockMarkit::Quote.new('twtr')
      expect( quote.symbol ).to eq(:TWTR)
    end
  end

  describe '#fetch' do
    let(:quote) {StockMarkit::Quote.new(:twtr)}

    it 'fetches the stock quote data from the api' do
      VCR.use_cassette 'quote/twtr' do
        expect( quote.name ).to be_nil
        quote.fetch
        expect( quote.name ).not_to be_nil
      end
    end

    it 'sets the timestamp as a utc time' do
      VCR.use_cassette 'quote/twtr' do
        quote.fetch
        expect( quote.timestamp.zone ).to eq('UTC')
      end
    end
  end

  describe '#update' do
    let(:quote) {StockMarkit::Quote.new(:twtr)}

    it 'updates quote from the api' do
      VCR.use_cassette 'quote/twtr_update' do
        quote.fetch
        expect( quote.name ).not_to be_nil
        quote.instance_eval('@name = nil')
        expect( quote.name ).to be_nil
        quote.update
        expect( quote.name ).not_to be_nil
      end
    end
  end
end
