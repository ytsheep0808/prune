# coding:utf-8

module Prune
  module PObjects
    class PStream < Base
      def initialize
        @stream = []
      end

      def <<(text)
        @stream << text
      end

      def length
        self.to_s.size
      end

      def to_s
        ["stream", @stream, "endstream"].flatten.join(LF)
      end
    end
  end
end
