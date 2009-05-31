# coding:utf-8

require "pdf_type/pdf_base_type"

module Prune
  module PObjects
    class PStream < PObject
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
