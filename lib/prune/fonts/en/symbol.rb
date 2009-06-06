# coding:utf-8

require "pdf_font/font_base"
require "pdf_object/font"

module Prune 
  module Fonts
    class Symbol < Base
      include PdfObject

      def initialize(pdf)
        super(pdf)
        @main_object = Font.new(
          :Name => :symbol,
          :Subtype => :Type1,
          :BaseFont => :Symbol,
          :Encoding => :StandardEncoding)
        @font_objects << @main_object
        register
      end
    end
  end
end
