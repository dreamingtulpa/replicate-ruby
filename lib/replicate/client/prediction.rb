# frozen_string_literal: true

module Replicate
  class Client
    # Methods for the Prediction API
    module Prediction
      # Get a prediction
      # @see https://replicate.com/docs/reference/http#get-prediction
      def retrieve_prediction(id)
        get("predictions/#{id}")
      end

      # Get a list of predictions
      # @see https://replicate.com/docs/reference/http#get-predictions
      def list_predictions(cursor = nil)
        get("predictions", cursor: cursor)
      end

      # Create a prediction
      # @see https://replicate.com/docs/reference/http#create-prediction
      def create_prediction(params)
        post("predictions", params)
      end

      # Cancel a prediction
      # @see https://replicate.com/docs/reference/http#cancel-prediction
      def cancel_prediction(id)
        post("predictions/#{id}/cancel")
      end
    end
  end
end
