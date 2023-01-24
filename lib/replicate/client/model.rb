# frozen_string_literal: true

module Replicate
  class Client
    # Methods for the Prediction API
    module Model
      # Get a model
      # @see https://replicate.com/docs/reference/http#get-model
      def retrieve_model(model, version: :latest)
        case version
        when :latest
          response = api_endpoint.get("models/#{model}")
          Replicate::Record::Model.new(self, response)
        when :all
          response = api_endpoint.get("models/#{model}/versions")
          response["results"].map! { |result| Replicate::Record::ModelVersion.new(self, result) }
          response
        else
          response = api_endpoint.get("models/#{model}/versions/#{version}")
          Replicate::Record::ModelVersion.new(self, response)
        end
      end

      # Get a collection of models
      # @see https://replicate.com/docs/reference/http#get-collection
      def retrieve_collection(slug)
        api_endpoint.get("collections/#{slug}")
      end
    end
  end
end
