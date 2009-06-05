# coding:utf-8
module Prune
  module PObjects
    class PStream < Base
      # Initialize.
      def initialize
        @stream = []
      end

      # Add content.
      def <<(text)
        raise PStreamTypeError unless text.instance_of?(String)
        @stream << text
      end

      # Length of the content.
      def length
        self.to_s.size
      end

      # Convert content to string.
      def to_s
        ["stream", @stream, "endstream"].flatten.join(LF)
      end
    end
  end
end
