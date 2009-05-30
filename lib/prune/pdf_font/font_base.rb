# coding:utf-8

require "pdf_errors"

module Prune 
  module PdfFont
    class FontBase
      attr_reader :font_objects, :main_object

      def initialize(pdf)
        @pdf = pdf
        @font_objects = []
        @main_object = nil
        @registered = false
      end

      def reference_id
        @main_object.reference_id
      end

      def register
        unless @registered
          obj_id = @pdf.object_list.size + 1
          @font_objects.each_with_index{|font_object, index|
            font_object.obj_id = obj_id + index
            @pdf.object_list << font_object
          }
          @registered = true
        end
      end
    end
  end
end
