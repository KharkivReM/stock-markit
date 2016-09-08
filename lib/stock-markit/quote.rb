require 'active_support/time'
require 'httparty'
require 'oj'
require 'stock-markit/api_exception'

module StockMarkit

  # Stock Quote
  #
  # @attr_reader [String] status The status from the api call
  # @attr_reader [String] name The company name
  # @attr_reader [String, Symbol] symbol The ticker symbol of the company
  # @attr_reader [Float] last_price The last price of the company's stock
  # @attr_reader [Float] change The change in price of the company's stock since the previous trading day's close
  # @attr_reader [Float] change_percent The change percent in price of the company's stock since the previous trading day's close
  # @attr_reader [Time] timestamp The last time the company's stock was traded
  # @attr_reader [Float] ms_date  The last time the company's stock was traded in exchange-local timezone. Represented as an OLE Automation date.
  # @attr_reader [Integer] market_cap The company's market cap
  # @attr_reader [Integer] volume The trade volume of the company's stock
  # @attr_reader [Float] change_ytd The change in price of the company's stock since the start of the year
  # @attr_reader [Float] change_percent_ytd The change percent in price of the company's stock since the start of the year
  # @attr_reader [Float] high The high price of the company's stock in the trading session
  # @attr_reader [Float] low The low price of the company's stock in the trading session
  # @attr_reader [Float] open The opening price of the company's stock at the start of the trading session
  #
  # @author Michael Heijmans  (mailto:parabuzzle@gmail.com)
  #
  # Copyright:: Copyright (c) 2016 Michael Heijmans
  # License::   MIT
  class Quote
    include ::HTTParty
    base_uri 'dev.markitondemand.com'

    attr_reader :status, :name, :symbol, :last_price,
                :change, :change_percent, :timestamp,
                :ms_date, :market_cap, :volume,
                :change_ytd, :change_percent_ytd,
                :high, :low, :open

    # @param [String, Symbol] symbol The stock's ticker symbol
    def initialize(symbol)
      @symbol   = symbol.to_sym.upcase
      @options  = { query: {symbol: @symbol} }
    end

    # @return <self> on successful api call
    # @return <False> on failed api call - check #message for failure message
    # @see #update
    def fetch
      update
    end

    # @return <self> on successful api call
    # @return <False> on failed api call - check #message for failure message
    # @see #fetch
    def update
      lookup_with_api
    end

    private

      def lookup_with_api
        results = self.class.get("/MODApis/Api/v2/Quote/json", @options)
        unless results.code == 200
          raise ApiException.new("An error occured while attempting to communicate with the api", results)
        end
        map_stock( Oj.load( results.body ) )
      end

      def map_stock(stock)
        if stock["Message"]
          @status = stock["Message"]
          return false
        end
        @status             = stock["Status"]
        @name               = stock["Name"]
        @last_price         = stock["LastPrice"]
        @change             = stock["Change"]
        @change_percent     = stock["ChangePercent"]
        @timestamp          = parse_time(stock["Timestamp"])
        @ms_date            = stock["MSDate"]
        @market_cap         = stock["MarketCap"]
        @volume             = stock["Volume"]
        @change_ytd         = stock["ChangeYTD"]
        @change_percent_ytd = stock["ChangePercentYTD"]
        @high               = stock["High"]
        @low                = stock["Low"]
        @open               = stock["Open"]
        return self
      end

      def parse_time(stamp)
        timezone = ActiveSupport::TimeZone["Eastern Time (US & Canada)"]
        timezone.parse(stamp).utc
      end

  end
end
