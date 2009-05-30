# coding:utf-8

require "pdf_font/font_base"
require "pdf_object/font"

module RubyPdfBuilder
  module PdfFont
    class CourierBoldOblique < FontBase
      include PdfObject

      def initialize(pdf)
        super(pdf)
        @main_object = Font.new(
          :Name => :courier_bold_oblique,
          :Subtype => :Type1,
          :BaseFont => "Courier-BoldOblique".to_sym,
          :Encoding => :StandardEncoding)
        @font_objects << @main_object
        register
      end
    end
  end
end
