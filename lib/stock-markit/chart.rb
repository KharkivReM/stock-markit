require 'active_support/time'
require 'httparty'
require 'oj'
require 'stock-markit/api_exception'

module StockMarkit

  # Stock Chart Object
  #
  # @attr_reader [StockMarkit::ChartResult] results The chart results
  #
  # @author Michael Heijmans  (mailto:parabuzzle@gmail.com)
  #
  # Copyright:: Copyright (c) 2016 Michael Heijmans
  # License::   MIT
  class Chart
    include ::HTTParty
    base_uri 'dev.markitondemand.com'

    attr_reader :results

    # @option opts [Boolean] :normalized Show data in price units (false) or percentages (true)
    # @option opts [Time] :start_date The beginning date for the chart
    # @option opts [Time] :end_date The end date of the chart
    # @option opts [Integer] :offset Number of days back that chart should end. Defaults to 0 if not specified. May be used instead of :end_date for interday requests.
    # @option opts [Integer] :number_of_days Number of days that should be shown on the chart. Required for intraday requests. May be used instead of :start_date for interday requests.
    # @option opts [Symbol] :data_period The type of data requested. :Minute, :Hour, :Day, :Week, :Month, :Quarter, :Year
    # @option opts [Integer] :data_interval For intraday data, specifies the number of periods between data points. e.g. if DataPeriod is Minute and DataInterval is 5, you will get a chart with five minute intervals. Must be 0 or null for interday charts
    # @option opts [Symbol] :label_period The TimePeriod over which to create labels. Control how often you want labels by setting LabelInterval. :Minute, :Hour, :Day, :Week, :Month, :Quarter, :Year
    # @option opts [Integer] :label_interval How many LabelPeriods to skip between labels
    # @option opts [Array<StockMarkit::Element>] :elements An Array of 1 or more Elements.
    def initialize(opts)
      @opts = opts
    end

    # @return [Boolean] value of the passed normalized parameter on instantiation
    def normalized?
      return true if @opts[:normalized].nil?
      @opts[:normalized]
    end

    # @return [String] value of passed start_time parameter in ISO8601 formatted Eastern Time
    def start_date
      format_time(@opts[:start_date])
    end

    # @return [String] value of passed end_time parameter in ISO8601 formatted Eastern Time
    def end_date
      format_time(@opts[:end_date])
    end

    # @return [Integer] value of passed offset parameter on instantiation
    def offset
      @opts[:offset]
    end

    # @return [Integer] value of passed number_of_days parameter on instantiation
    def number_of_days
      @opts[:number_of_days]
    end

    # @return [Symbol] value of passed data_period parameter on instantiation
    def data_period
      raise "valid data_periods are #{allowed_periods.join(", ")}" unless allowed_periods.include? @opts[:data_period]
      @opts[:data_period].to_s.capitalize
    end

    # @return [Integer] value of passed data_interval parameter on instantiation
    def data_interval
      @opts[:data_interval]
    end

    # @return [Symbol] value of passed label_period parameter on instantiation
    def label_period
      return nil unless @opts[:label_period]
      raise "valid label_periods are #{allowed_periods.join(", ")}" unless allowed_periods.include? @opts[:label_period]
      @opts[:label_period].to_s.capitalize
    end

    # @return [Integer] value of passed label_interval parameter on instantiation
    def label_interval
      @opts[:label_interval]
    end

    # @return [Array] List of normalized elements passed on instantiation
    def elements
      @opts[:elements].map{ |element| {"Symbol" => element.symbol, "Type" => element.type, "Params" => [element.params]} }
    end

    # loads the @results on first call or returns results on subsequent calls
    #
    # @return [StockMarkit::ChartResults] results object
    def fetch
      @results || update
    end

    # updates the data from the api
    #
    # @return [StockMarkit::ChartResult] results object
    def update
      @results = lookup_with_api
    end

    private

      def allowed_periods
        [
          :minute,
          :hour,
          :day,
          :week,
          :month,
          :quarter,
          :year,
        ]
      end

      def format_time(time)
        return nil unless time
        time.in_time_zone('Eastern Time (US & Canada)').iso8601
      end

      def options
        {
          query: {
            parameters: encoded_parameters
          }
        }
      end

      def encoded_parameters
        parameters.to_json
      end

      def parameters
        params = {}

        params.store("Normalized", normalized?)
        params.store("StartDate", start_date)         if start_date
        params.store("EndDate", end_date)             if end_date
        params.store("EndOffsetDays", offset)         if offset
        params.store("NumberOfDays", number_of_days)  if number_of_days
        params.store("DataPeriod", data_period)       if data_period
        params.store("DataInterval", data_interval)   if data_interval
        params.store("LabelPeriod", label_period)     if label_period
        params.store("LabelInterval", label_interval) if label_interval

        params.store("Elements", elements)

        return params
      end

      def lookup_with_api
        results = self.class.get("/MODApis/Api/v2/InteractiveChart/json", options)
        if results.code != 200
          raise ApiException.new("An error occured while attempting to communicate with the api", results)
        end
        StockMarkit::ChartResult.new( Oj.load( results.body ) )
      end

  end
end
