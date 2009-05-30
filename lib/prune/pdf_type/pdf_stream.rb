# coding:utf-8

require "pdf_type/pdf_base_type"

module RubyPdfBuilder
  module PdfType
    class PdfStream < PdfBaseType
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
