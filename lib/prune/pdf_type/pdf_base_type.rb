# coding:utf-8

require "pdf_errors"

module RubyPdfBuilder
  module PdfType
    class PdfBaseType
      # インデント
      @@indent = 0

      def space
        "  " * @@indent
      end

      def indent!
        @@indent += 1
      end

      def outdent!
        @@indent -= 1
      end

      def value_to_s(value)
        if value.is_a?(Symbol)
          return "/" + value.to_s
        elsif value.is_a?(String)
          return "(%s)" % value
        elsif value.is_a?(PdfArray) || value.is_a?(PdfDictionary)
          indent!
          out = LF + space + value.to_s
          outdent!
          return out
        elsif value.respond_to?(:reference_id)
          return value.reference_id
        else
          return value.to_s
        end
      end
    end
  end
end
