# coding:utf-8

require "pdf_font/font_base"
require "pdf_object/font"

module Prune 
  module PdfFont
    class HelveticaOblique < FontBase
      include PdfObject

      def initialize(pdf)
        super(pdf)
        @main_object = Font.new(
          :Name => :helvetica_oblique,
          :Subtype => :Type1,
          :BaseFont => "Helvetica-Oblique".to_sym,
          :Encoding => :StandardEncoding)
        @font_objects << @main_object
        register
      end
    end
  end
end
