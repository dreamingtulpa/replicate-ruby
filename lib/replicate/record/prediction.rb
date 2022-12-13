# frozen_string_literal: true

module Replicate
  module Record
    class Prediction < Base
      def refetch
        @data = client.retrieve_prediction(id).data
      end

      def cancel
        @data = client.cancel_prediction(id).data
      end

      def finished?
        case status
        when "succeeded", "failed", "canceled"
          true
        else
          false
        end
      end
    end
  end
end
