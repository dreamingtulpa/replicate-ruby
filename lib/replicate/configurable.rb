# frozen_string_literal: true

module Replicate
  module Configurable
    attr_accessor :api_token
    attr_writer :api_endpoint

    class << self
      # List of configurable keys for {Datatrans::Client}
      # @return [Array] of option keys
      def keys
        @keys ||= %i[api_token api_endpoint]
      end
    end

    # Set configuration options using a block
    def configure
      yield self
    end

    # API endpoint methods
    def api_endpoint
      @api_endpoint ||= "https://api.replicate.com/v1"
    end

    private

    def options
      Hash[Replicate::Configurable.keys.index_with { |key| send(key) }]
    end
  end
end
