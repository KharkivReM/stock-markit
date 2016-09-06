module StockMarkit

  # Stock Chart Element Object
  #
  # @attr_reader [String] symbol The Stock Symbol
  # @attr_reader [String] type The type of element. Must be one of :price, :volume, or :sma
  # @attr_reader [String] params Params vary for each Type. The following Types accept Params. For the other types, Params should be null or an empty array. "sma": [period], "price": ["ohlc"] for open/high/low/close, ["c"] for close only.
  #
  # @author Michael Heijmans  (mailto:parabuzzle@gmail.com)
  #
  # Copyright:: Copyright (c) 2016 Michael Heijmans
  # License::   MIT
  class Element
    attr_reader :symbol, :type, :params

    # @param [String] symbol The stock's ticker symbol
    # @param [Symbol] type The type of element. Must be one of :price, :volume, or :sma
    # @param [Array]  params Params vary for each Type. The following Types accept Params. For the other types, Params should be null or an empty array. "sma": [period], "price": ["ohlc"] for open/high/low/close, ["c"] for close only.
    def initialize(symbol, type, params=nil)
      @symbol = symbol.to_s.upcase
      @type   = type.to_s
      @params = params || default_params
    end

    private

      def default_params
        case @type
        when "price"
          "c"
        when "sma"
          :week
        end
      end

  end
end
