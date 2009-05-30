# coding:utf-8

require "pdf_font/font_base"
require "pdf_object/font"

module RubyPdfBuilder
  module PdfFont
    class TimesBold < FontBase
      include PdfObject

      def initialize(pdf)
        super(pdf)
        @main_object = Font.new(
          :Name => :time_bold,
          :Subtype => :Type1,
          :BaseFont => "Times-Bold".to_sym,
          :Encoding => :StandardEncoding)
        @font_objects << @main_object
        register
      end
    end
  end
end
