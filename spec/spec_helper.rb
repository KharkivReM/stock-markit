# This file is loaded before rspec tests are run
require 'simplecov'
require 'simplecov-rcov'
require 'coveralls'
require 'pry'

require_relative './support/vcr.rb'

SimpleCov.start do
  add_filter '/spec/'
  add_group 'lib', 'lib/stock-markit'
  SimpleCov.minimum_coverage 75
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
      SimpleCov::Formatter::HTMLFormatter,
      SimpleCov::Formatter::RcovFormatter,
      Coveralls::SimpleCov::Formatter
  ]
end

Coveralls.wear!
