module StockMarkit

  # Lookup a Stock by Symbol
  #
  # @attr_reader [String,Symbol] symbol The symbol of the stock to lookup
  # @attr_reader [Hash] options Options hash for httparty
  # @attr_reader [Array<StockMarkit::Stock>] results The stocks that match the symbol. This is populated on the first call of <#fetch>
  #
  # @author Michael Heijmans  (mailto:parabuzzle@gmail.com)
  #
  # Copyright:: Copyright (c) 2016 Michael Heijmans
  # License::   MIT
  class Lookup
    include ::HTTParty
    base_uri 'dev.markitondemand.com'

    attr_reader :symbol, :results

    # @param [String, Symbol] symbol The stock's ticker symbol
    def initialize(symbol)
      @symbol  = symbol.to_sym.upcase
      @options = { query: {input: @symbol} }
    end

    # Fetch stocks matching @symbol from the api
    #
    # This method memoizes the results and returns the contents
    # of the results variable instead of asking the api again
    # @return [Array<StockMarkit::Stock>]
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

