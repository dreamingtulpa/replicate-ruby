# frozen_string_literal: true

module Replicate
  class Client
    # Methods for the Prediction API
    module Prediction
      # Get a prediction
      # @see https://replicate.com/docs/reference/http#get-prediction
      def retrieve_prediction(id)
        response = api_endpoint.get("predictions/#{id}")
        Replicate::Record::Prediction.new(self, response)
      end

      # Get a list of predictions
      # @see https://replicate.com/docs/reference/http#get-predictions
      def list_predictions(cursor = nil)
        response = api_endpoint.get("predictions", cursor: cursor)
        response["results"].map! { |result| Replicate::Record::Prediction.new(self, result) }
        response
      end

      # Create a prediction
      # @see https://replicate.com/docs/reference/http#create-prediction
      def create_prediction(params)
        params[:webhook_completed] ||= webhook_url
        response = api_endpoint.post("predictions", params)
        Replicate::Record::Prediction.new(self, response)
      end

      # Cancel a prediction
      # @see https://replicate.com/docs/reference/http#cancel-prediction
      def cancel_prediction(id)
        response = api_endpoint.post("predictions/#{id}/cancel")
        Replicate::Record::Prediction.new(self, response)
      end
    end
  end
end
