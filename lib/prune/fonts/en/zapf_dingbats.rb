# coding:utf-8

require "pdf_font/font_base"
require "pdf_object/font"

module Prune 
  module PdfFont
    class ZapfDingbats < FontBase
      include PdfObject

      def initialize(pdf)
        super(pdf)
        @main_object = Font.new(
          :Name => :zapf_dingbats,
          :Subtype => :Type1,
          :BaseFont => :ZapfDingbats,
          :Encoding => :StandardEncoding)
        @font_objects << @main_object
        register
      end
    end
  end
end
