# frozen_string_literal: true

module Replicate
  module Record
    class Prediction < Base
      def refetch
        self.assign_attributes = client.retrieve_prediction(id)
      end

      def cancel
        self.assign_attributes = client.cancel_prediction(id)
      end
    end
  end
end
