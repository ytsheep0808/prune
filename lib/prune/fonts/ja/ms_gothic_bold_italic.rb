# coding:utf-8

require "pdf_font/font_base"
require "pdf_objects"
require "pdf_types"

module Prune 
  module Fonts
    class MsGothicBoldItalic < Base
      include PdfType
      include PdfObject

      def initialize(pdf)
        super(pdf)
        font_descriptor = FontDescriptor.new(
          :FontName => "MS-Gothic,BoldItalic".to_sym,
          :Ascent => 859,
          :Descent => -140,
          :CapHeight => 769,
          :MissingWidth => 500,
          :Flags => 262213,
          :FontBBox => PdfArray.new([0, -136, 1000, 859]),
          :ItailcAngle => -11,
          :StemV => 156)
        @font_objects << font_descriptor
        # フォント幅の指定
        w = PdfArray.new([
          1, PdfArray.new([
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500]),
          231, PdfArray.new([
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500]),
          327, PdfArray.new([
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500]),
          631, PdfArray.new([500])])
        font_body = Font.new(
          :Subtype => :CIDFontType0,
          :BaseFont => "MS-Gothic,BoldItalic".to_sym,
          :CIDSystemInfo => PdfDictionary.new({
            :Registry => "Adobe",
            :Ordering => "Japan1",
            :Supplement => 2}),
          :FontDescriptor => font_descriptor,
          :DW => 1000,
          :DW2 => PdfArray.new([880, -1000]),
          :W => w)
        @font_objects << font_body
        @main_object = Font.new(
          :Name => :ms_gothic_bold_italic,
          :Subtype => :Type0,
          :BaseFont => "MS-Gothic,BoldItalic".to_sym,
          :Encoding => "UniJIS-UCS2-H".to_sym,
          :DescendantFonts => PdfArray.new([font_body]))
        @font_objects << @main_object
        register
      end
    end
  end
end
