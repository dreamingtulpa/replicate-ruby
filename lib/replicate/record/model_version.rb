# frozen_string_literal: true

module Replicate
  module Record
    class ModelVersion < Base
      def predict(input, webhook = nil)
        params = {}
        params[:version] = id
        params[:input] = input
        params[:webhook] = webhook
        client.create_prediction(params)
      end
    end
  end
end
