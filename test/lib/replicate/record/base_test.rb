# frozen_string_literal: true

require "test_helper"

class Replicate::Record::BaseTest < MiniTest::Test
  def test_method_missing
    record = Replicate::Record::Base.new(client, "id" => "test")
    assert_equal "test", record.id

    assert_raises NoMethodError do
      record.something
    end
  end
end
