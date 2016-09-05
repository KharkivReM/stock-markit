module StockMarkit

  # Stock Object
  #
  # @attr_reader [String] symbol The Stock Symbol
  # @attr_reader [String] name The company name
  # @attr_reader [String] exchange The exchange the stock is traded on
  #
  # @author Michael Heijmans  (mailto:parabuzzle@gmail.com)
  #
  # Copyright:: Copyright (c) 2016 Michael Heijmans
  # License::   MIT
  class Stock
    attr_reader :symbol, :name, :exchange

    # @param [String] symbol The stock's ticker symbol
    # @param [String] name The name of the company
    # @param [String] exchange Optional exchange string
    def initialize(symbol, name, exchange=nil)
      @symbol   = symbol
      @name     = name
      @exchange = exchange
    end

  end
end
