require 'spec_helper'
require 'stock-markit/chart_result'

RSpec.describe StockMarkit::ChartResult do

  let(:json) {
    {
    "Labels" => nil,
    "Positions" => [1, 2],
    "Dates" => ["2016-09-06T19:13:20-07:00", "2016-09-05T19:13:20-07:00"],
    "Elements" => [ :element ]
    }
  }

  let(:result) { StockMarkit::ChartResult.new(json) }

  it "maps labels" do
    expect(result.labels).to be_nil
  end

  it "maps positions" do
    expect(result.positions).to be_a(Array)
    expect(result.positions).to include(1)
  end

  it "maps dates" do
    expect(result.dates).to be_a(Array)
  end

  it "maps elements" do
    expect(result.elements).to be_a(Array)
    expect(result.elements).to include(:element)
  end

  describe "#dates" do

    it "returns parsed timestamps" do
      expect(result.dates.first).to be_a(Time)
    end

    it "returns timestamps in UTC" do
      expect(result.dates.first.zone).to eq("UTC")
    end

  end
end
