# frozen_string_literal: true

module Replicate
  module Record
    class ModelVersion < Base
      def create_prediction(params)
        params[:version] = id
        client.create_prediction(params)
      end
    end
  end
end
