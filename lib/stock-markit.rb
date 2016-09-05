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
  def self.require_lib(lib)
    require lib
  end

  # iterates through the passed in array of
  # library paths and requires each of them
  def self.require_libs(libs)
    libs.each do |lib|
      self.require_lib(lib)
    end
  end

  def self.lookup(symbol)
    Lookup.new(symbol).fetch
  end

  def self.quote(symbol)
    Quote.new(symbol).fetch
  end

end

$:.concat [File.expand_path('../', __FILE__),File.expand_path('../stock-markit', __FILE__)]

# Require all ruby files in the stock-markit directory
StockMarkit.require_libs Dir.glob(File.expand_path('../stock-markit', __FILE__) + '/*.rb')
