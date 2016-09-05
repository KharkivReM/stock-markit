# Stock Quote Object
#
# Author::    Michael Heijmans  (mailto:parabuzzle@gmail.com)
# Copyright:: Copyright (c) 2016 Michael Heijmans
# License::   MIT

require 'active_support/time'

module StockMarkit
  class Quote
    include ::HTTParty
    base_uri 'dev.markitondemand.com'

    attr_reader :status, :name, :symbol, :last_price,
                :change, :change_percent, :timestamp,
                :ms_date, :market_cap, :volume,
                :change_ytd, :change_percent_ytd,
                :high, :low, :open

    attr_accessor :options

    def initialize(symbol, options = nil)
      @symbol   = symbol.to_sym.upcase
      @options  =  options || { query: {symbol: @symbol} }
    end

    def fetch
      update
    end

    def update
      lookup_with_api
    end

    private

      def lookup_with_api
        map_stock( Oj.load( self.class.get("/MODApis/Api/v2/Quote/json", @options).body) )
      end

      def map_stock(stock)
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
        # Set timezone
        zone = Time.zone
        Time.zone = 'Eastern Time (US & Canada)'

        time = Time.zone.parse( stamp )

        # Put the original zone back
        Time.zone = zone

        # Return the utc version
        return time.utc
      end

  end
end
