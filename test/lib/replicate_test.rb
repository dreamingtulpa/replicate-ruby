# frozen_string_literal: true

require "test_helper"

class ReplicateTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Replicate::VERSION
  end
end
