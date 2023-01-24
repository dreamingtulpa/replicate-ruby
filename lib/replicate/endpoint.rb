# frozen_string_literal: true

require "faraday"
require "faraday/net_http"
require "faraday/retry"
require "faraday/multipart"
require "addressable/uri"

module Replicate
  # Network layer for API clients.
  class Endpoint
    attr_reader :endpoint_url, :api_token, :content_type

    def initialize(endpoint_url:, api_token:, content_type: 'application/json')
      @endpoint_url = endpoint_url
      @api_token = api_token
      @content_type = content_type
    end

    # Make a HTTP GET request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Query and header params for request
    # @return [Sawyer::Resource]
    def get(url, options = {})
      request :get, url, options
    end

    # Make a HTTP POST request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Body and header params for request
    # @return [Sawyer::Resource]
    def post(url, options = {})
      request :post, url, options.to_json
    end

    # Make a HTTP PUT request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Body and header params for request
    # @return [Sawyer::Resource]
    def put(url, options = {})
      request :put, url, options.to_json
    end

    # Make a HTTP PATCH request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Body and header params for request
    # @return [Sawyer::Resource]
    def patch(url, options = {})
      request :patch, url, options.to_json
    end

    # Make a HTTP DELETE request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Query and header params for request
    # @return [Sawyer::Resource]
    def delete(url, options = {})
      request :delete, url, options
    end

    # Make a HTTP HEAD request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options [Hash] Query and header params for request
    # @return [Sawyer::Resource]
    def head(url, options = {})
      request :head, url, options
    end

    # Hypermedia agent for the datatrans API
    #
    # @return [Sawyer::Agent]
    def agent
      @agent ||= Faraday.new(url: endpoint_url) do |conn|
        conn.request :retry
        conn.request :authorization, 'Token', api_token if api_token
        conn.headers["Content-Type"] = content_type

        conn.adapter :net_http
      end
    end

    # Response for last HTTP request
    #
    # @return [Sawyer::Response]
    def last_response
      @last_response if defined? @last_response
    end

    private

    def request(method, path, data)
      @last_response = agent.send(method, Addressable::URI.parse(path.to_s).normalize.to_s, data)
      case @last_response.status
      when 400
        raise Error, "#{@last_response.status} #{@last_response.reason_phrase}: #{JSON.parse(@last_response.body)}"
      else
        case content_type
        when 'application/json'
          JSON.parse(@last_response.body)
        else
          @last_response.body
        end
      end
    end
  end
end
