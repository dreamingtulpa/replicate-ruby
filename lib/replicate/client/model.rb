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
          Replicate::Record::Model.new(self, get("models/#{model}"))
        when :all
          response = get("models/#{model}/versions")
          response["results"].map! { |result| Replicate::Record::ModelVersion.new(self, result) }
          response
        else
          Replicate::Record::ModelVersion.new(self, get("models/#{model}/versions/#{version}"))
        end
      end

      # Get a collection of models
      # @see https://replicate.com/docs/reference/http#get-collection
      def retrieve_collection(slug)
        get("collections/#{slug}")
      end
    end
  end
end
