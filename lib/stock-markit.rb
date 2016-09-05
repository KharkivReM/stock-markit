# This library allows you to persist objects with meta data
# StockMarkit supports data expiry and is designed with thread safety
#
# Author::    Michael Heijmans  (mailto:parabuzzle@gmail.com)
# Copyright:: Copyright (c) 2016 Michael Heijmans
# License::   MIT

require 'httparty'
require 'hashie'
require 'oj'

module StockMarkit

  # require library file that was passed
  # @param [String] lib Library path to require
  def self.require_lib(lib)
    require lib
  end

  # Iterates through the passed in array of
  # library paths and requires each of them
  # @param [Array] libs Array of libraries to require
  def self.require_libs(libs)
    libs.each do |lib|
      self.require_lib(lib)
    end
  end

  # Uses the lookup service to find stocks with the given symbol
  # @param [String, Symbol] symbol The ticker symbol to lookup
  # @return [Array<StockMarkit::Stock>] An Array of Stock Objects that match the given symbol
  # @see StockMarkit::Lookup
  def self.lookup(symbol)
    Lookup.new(symbol).fetch
  end


  # Uses the quote service to get a quote for the given symbol
  # @param [String, Symbol] symbol The ticker symbol to lookup
  # @return [StockMarkit::Quote] A populated quote object
  # @see StockMarkit::Quote
  def self.quote(symbol)
    Quote.new(symbol).fetch
  end

end

$:.concat [File.expand_path('../', __FILE__),File.expand_path('../stock-markit', __FILE__)]

# Require all ruby files in the stock-markit directory
StockMarkit.require_libs Dir.glob(File.expand_path('../stock-markit', __FILE__) + '/*.rb')
