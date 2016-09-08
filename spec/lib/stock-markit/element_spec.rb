require 'spec_helper'

RSpec.describe StockMarkit::Element do

  let(:element_price)      { StockMarkit::Element.new(:twtr, :price)}
  let(:element_average)    { StockMarkit::Element.new(:twtr, :sma)}
  let(:element_avg_custom) { StockMarkit::Element.new(:twtr, :sma, :day)}

  it "has default params" do
    expect(element_price.params).to eq("c")
  end

  it "sets the default period for sma to week" do
    expect(element_average.params).to eq(:week)
  end

  it 'accepts custom params' do
    expect(element_avg_custom.params).to eq(:day)
  end
end
