# coding:utf-8

require "pdf_types"
require "pdf_errors"

module RubyPdfBuilder
  module PdfObject
    class BaseObject
      include PdfType

      attr_accessor :obj_id, :revision

      def initialize(pdf)
        @pdf = pdf
        @obj_id = 0
        @revision = 0
        @content = nil
        @stream = nil
        @registered = false
      end

      def to_s
        raise ObjectNotRegisteredError if @obj_id <= 0
        out = []
        out << "%d %d obj" % [@obj_id, @revision]
        out << @content.to_s
        out << "endobj"
        return out.join(LF)
      end

      def reference_id
        "%d %d R" % [@obj_id, @revision]
      end

      def register
        unless @registered
          @obj_id = @pdf.object_list.size + 1
          @pdf.object_list << self
          @registered = true
        end
      end

      private
      def inspect
        self.to_s
      end
    end
  end
end
