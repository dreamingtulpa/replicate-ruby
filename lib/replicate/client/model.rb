# frozen_string_literal: true

module Replicate
  class Client
    # Methods for the Prediction API
    module Model
      # Get a model
      # @see https://replicate.com/docs/reference/http#get-model
      def retrieve_model(model_owner, model_name, version: :latest)
        case version
        when :latest
          get("models/#{model_owner}/#{model_name}")
        when :all
          get("models/#{model_owner}/#{model_name}/versions")
        else
          get("models/#{model_owner}/#{model_name}/versions/#{version}")
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
