# coding:utf-8

require "pdf_font/font_base"
require "pdf_object/font"

module Prune 
  module PdfFont
    class CourierOblique < FontBase
      include PdfObject

      def initialize(pdf)
        super(pdf)
        @main_object = Font.new(
          :Name => :courier_oblique,
          :Subtype => :Type1,
          :BaseFont => "Courier-Oblique".to_sym,
          :Encoding => :StandardEncoding)
        @font_objects << @main_object
        register
      end
    end
  end
end