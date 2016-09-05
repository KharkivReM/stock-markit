# Stock Object
#
# Author::    Michael Heijmans  (mailto:parabuzzle@gmail.com)
# Copyright:: Copyright (c) 2016 Michael Heijmans
# License::   MIT

module StockMarkit
  class Stock
    attr_reader :symbol, :name, :exchange

    def initialize(symbol, name, exchange=nil)
      @symbol   = symbol
      @name     = name
      @exchange = exchange
    end

  end
end
