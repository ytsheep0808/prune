# coding:utf-8

require "pdf_font/font_base"
require "pdf_object/font"

module Prune 
  module Fonts
    class TimesItalic < Base
      include PdfObject

      def initialize(pdf)
        super(pdf)
        @main_object = Font.new(
          :Name => :times_italic,
          :Subtype => :Type1,
          :BaseFont => "Times-Italic".to_sym,
          :Encoding => :StandardEncoding)
        @font_objects << @main_object
        register
      end
    end
  end
end
