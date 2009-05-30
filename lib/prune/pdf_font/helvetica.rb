# coding:utf-8

require "pdf_font/font_base"

module RubyPdfBuilder
  module PdfFont
    class Helvetica < FontBase
      include PdfObject

      def initialize(pdf)
        super(pdf)
        @main_object = Font.new(
          :Name => :helvetica,
          :Subtype => :Type1,
          :BaseFont => :Helvetica,
          :Encoding => :StandardEncoding)
        @font_objects << @main_object
        register
      end
    end
  end
end
