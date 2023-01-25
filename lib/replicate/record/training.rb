# frozen_string_literal: true

module Replicate
  module Record
    class Training < Base
      def refetch
        @data = client.retrieve_training(id).data
      end
    end
  end
end
