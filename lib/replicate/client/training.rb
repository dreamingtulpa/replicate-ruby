# frozen_string_literal: true

module Replicate
  class Client
    # Methods for the Prediction API
    module Training
      # Get a training
      # @see https://replicate.com/blog/dreambooth-api
      def retrieve_training(id)
        response = dreambooth_endpoint.get("trainings/#{id}")
        Replicate::Record::Training.new(self, response)
      end

      # Create a training
      # @see https://replicate.com/blog/dreambooth-api
      def create_training(params)
        params[:webhook_completed] ||= webhook_url
        response = dreambooth_endpoint.post("trainings", params)
        Replicate::Record::Training.new(self, response)
      end
    end
  end
end
