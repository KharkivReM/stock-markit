#  Lookup a Stock by Symbol
#
# Author::    Michael Heijmans  (mailto:parabuzzle@gmail.com)
# Copyright:: Copyright (c) 2016 Michael Heijmans
# License::   MIT

module StockMarkit
  class Lookup
    include ::HTTParty
    base_uri 'dev.markitondemand.com'

    attr_accessor :symbol, :options, :results

    def initialize(symbol, options = nil )
      @symbol  = symbol.to_sym.upcase
      @options = options || { query: {input: @symbol} }
    end

    def fetch
      @results ||= lookup_with_api
    end

    private

      def lookup_with_api
        map_stocks( Oj.load( self.class.get("/MODApis/Api/v2/Lookup/json", @options).body) )
      end

      def map_stocks(stocks)
        stocks.map do |stock|
          Stock.new(stock["Symbol"], stock['Name'], stock["Exchange"])
        end
      end

  end
end

