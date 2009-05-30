# coding:utf-8

require "pdf_font/font_base"
require "pdf_object/font"

module RubyPdfBuilder
  module PdfFont
    class HelveticaBoldOblique < FontBase
      include PdfObject

      def initialize(pdf)
        super(pdf)
        @main_object = Font.new(
          :Name => :helvetica_bold_oblique,
          :Subtype => :Type1,
          :BaseFont => "Helvetica-BoldOblique".to_sym,
          :Encoding => :StandardEncoding)
        @font_objects << @main_object
        register
      end
    end
  end
end
