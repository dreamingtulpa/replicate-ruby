# frozen_string_literal: true

module Replicate
  module Record
    class Model < Base
      def initialize(params)
        params["latest_version"] = Replicate::Record::ModelVersion.new(params["latest_version"])
        super
      end
    end
  end
end
