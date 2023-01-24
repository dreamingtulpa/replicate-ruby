# frozen_string_literal: true

require "replicate/configurable"
require "replicate/endpoint"

require "replicate/client/model"
require "replicate/client/prediction"

module Replicate
  class Client
    include Replicate::Configurable

    include Replicate::Client::Model
    include Replicate::Client::Prediction

    def initialize(options = {})
      # Use options passed in, but fall back to module defaults
      Replicate::Configurable.keys.each do |key|
        value = options.key?(key) ? options[key] : Replicate.instance_variable_get(:"@#{key}")
        instance_variable_set(:"@#{key}", value)
      end
    end

    def api_endpoint
      @api_endpoint ||= Replicate::Endpoint.new(endpoint_url: api_endpoint_url, api_token: api_token)
    end

    def dreambooth_endpoint
      @dreambooth_endpoint ||= Replicate::Endpoint.new(endpoint_url: dreambooth_endpoint_url, api_token: api_token)
    end
  end
end
