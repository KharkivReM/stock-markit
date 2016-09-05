require 'spec_helper'

RSpec.describe 'StockMarkit::VERSION' do
  it 'returns a version string' do
    expect(StockMarkit::VERSION.class).to eq(String)
  end
end
