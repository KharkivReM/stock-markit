module StockMarkit

  # Api Exception Object
  #
  # @attr_reader [String] message The Error Message
  # @attr_reader [String] api_results The httparty object for inspecting
  #
  # @author Michael Heijmans  (mailto:parabuzzle@gmail.com)
  #
  # Copyright:: Copyright (c) 2016 Michael Heijmans
  # License::   MIT
  class ApiException < Exception

    attr_reader :api_results

    def initialize(message="Api Error", api_results=nil)
      @api_results = api_results
      super(message)
    end

  end
end
