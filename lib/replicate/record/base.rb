# frozen_string_literal: true

module Replicate
  module Record
    class Base
      attr_accessor :data
      attr_reader :client

      def initialize(client, params)
        @client = client
        @data = params
      end

      def method_missing(method_name, *args, &block)
        if data.key? method_name.to_s
          data[method_name.to_s]
        else
          super
        end
      end

      def inspect
        string = "#<#{self.class.name}:#{object_id} "
        fields = data.map { |attr, value| "#{attr}: #{value.inspect}" }
        string << fields.join(", ") << ">"
      end
    end
  end
end
