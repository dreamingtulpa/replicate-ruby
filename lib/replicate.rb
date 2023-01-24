# frozen_string_literal: true

require "replicate/version"
require "replicate/client"

require "replicate/record/base"
require "replicate/record/model"
require "replicate/record/model_version"
require "replicate/record/prediction"
require "replicate/record/upload"

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
