# frozen_string_literal: true

require "test_helper"

class Replicate::ClientTest < Minitest::Test
  def test_that_it_creates_a_new_client
    client = Replicate::Client.new(api_token: "test")
    assert_equal "test", client.api_token
  end
end
