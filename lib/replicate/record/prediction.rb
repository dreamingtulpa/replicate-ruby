# frozen_string_literal: true

module Replicate
  module Record
    class Prediction < Base
      def retrieve_prediction
        client.retrieve_prediction(id)
      end

      def cancel_prediction
        client.cancel_prediction(id)
      end
    end
  end
end
