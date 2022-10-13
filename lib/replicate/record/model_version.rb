# frozen_string_literal: true

module Replicate
  module Record
    class ModelVersion < Base
      def predict(input, webhook_completed = nil)
        params = {}
        params[:version] = id
        params[:input] = input
        params[:webhook_completed] = webhook_completed
        client.create_prediction(params)
      end
    end
  end
end
