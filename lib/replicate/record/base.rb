# frozen_string_literal: true

module Replicate
  module Record
    class Base
      def initialize(params)
        params.each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      def method_missing(method_name, *args, &block)
        if instance_variables.include? :"@#{method_name}"
          instance_variable_get "@#{method_name}"
        else
          super
        end
      end

      def client
        @client ||= Replicate.client
      end
    end
  end
end
