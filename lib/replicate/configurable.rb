# frozen_string_literal: true

module Replicate
  module Configurable
    attr_accessor :api_token, :webhook_url
    attr_writer :api_endpoint

    class << self
      # List of configurable keys for {Datatrans::Client}
      # @return [Array] of option keys
      def keys
        @keys ||= %i[api_token api_endpoint webhook_url]
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
      Hash[Replicate::Configurable.keys.map { |key| [key, send(key)] }]
    end
  end
end
