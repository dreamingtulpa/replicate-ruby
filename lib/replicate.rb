# frozen_string_literal: true

require "replicate/version"
require "replicate/client"

module Replicate
  class Error < StandardError; end

  class << self
    include Replicate::Configurable

    def client
      return @client if defined?(@client)
      @client = Replicate::Client.new(options)
    end
  end
end
