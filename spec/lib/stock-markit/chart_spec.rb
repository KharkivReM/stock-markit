require 'spec_helper'

RSpec.describe StockMarkit::Chart do

  let(:element) { StockMarkit::Element.new(:aapl, :price) }
  let(:options) {
    {
      normalized: false,
      number_of_days: 365,
      data_period: :day,
      elements: [element]
    }
  }
  let(:chart) { StockMarkit::Chart.new(options) }

  it 'fetches a chart from the api' do
    VCR.use_cassette 'chart/aapl' do
      expect( chart.fetch ).to be_a(StockMarkit::ChartResult)
      expect( chart.results ).not_to be_nil
    end
  end

  it 'raises a StockMarkit::ApiException when there is an error' do
    VCR.use_cassette 'chart/error' do
      element = StockMarkit::Element.new(:aapll, :price)
      options[:elements] = [element]
      chart = StockMarkit::Chart.new(options)
      expect{ chart.fetch }.to raise_error(StockMarkit::ApiException)
    end
  end
end
