# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "replicate"

require "minitest/autorun"
require "webmock/minitest"

def client
  @client ||= Replicate.client
end
