require 'active_support/time'

module StockMarkit

  # Stock Chart Result Object
  #
  # @author Michael Heijmans  (mailto:parabuzzle@gmail.com)
  #
  # Copyright:: Copyright (c) 2016 Michael Heijmans
  # License::   MIT
  class ChartResult

    # @param [Hash] the parsed json result from the chart api
    def initialize(json)
      @json = json
    end

    # @return [Hash] X Axis label position, text, and dates. The "dates" are in Microsoft "OA Date" format. The "text" is an ISO timestamp.
    def labels
      @json["Labels"]
    end

    # @return [Array] List of X coordinate positions for each data point returned, between 0 and 1.
    def positions
      @json["Positions"]
    end

    # @return [Array] Timestamps corresponding to each position in UTC
    def dates
      @json["Dates"].map { |date| parse_date(date) }
    end

    # @return [Array] requested element data
    def elements
      @json["Elements"]
    end


    private

      def parse_date(date)
        timezone = ActiveSupport::TimeZone["Eastern Time (US & Canada)"]
        timezone.parse(date).utc
      end

  end
end
