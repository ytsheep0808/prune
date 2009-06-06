# coding:utf-8

require "pdf_font/font_base"
require "pdf_objects"
require "pdf_types"

module Prune 
  module Fonts
    class JpDefault < Base
      include PdfType
      include PdfObject

      def initialize(pdf)
        super(pdf)
        font_descriptor = PdfObject::FontDescriptor.new(
          :Flags => 4,
          :Ascent => 752,
          :CapHeight => 737,
          :Descent => -221,
          :FontBBox => PdfArray.new([-92, -250, 1010, 922]),
          :FontName => "HeiseiKakuGo-W5".to_sym,
          :ItailcAngle => 0,
          :StemV => 114,
          :XHeight => 553)
        @font_objects << font_descriptor
        # フォント幅の指定
        w = PdfArray.new([
          # CID:1～配列長分のフォントは、配列のそれぞれの値の幅
          1, PdfArray.new([
            278, 278, 355, 556, 556, 889, 667, 191, 333, 333, 389, 584, 278,
            333, 278, 278, 556, 556, 556, 556, 556, 556, 556, 556, 556, 556,
            278, 278, 584, 584, 584, 556, 1015, 667, 667, 722, 722, 667, 611,
            778, 722, 278, 500, 667, 556, 833, 722, 778, 667, 778, 722, 667,
            611, 722, 667, 944, 667, 667, 611, 278, 556, 278, 469, 556, 333,
            556, 556, 500, 556, 556, 278, 556, 556, 222, 222, 500, 222, 833,
            556, 556, 556, 556, 333, 500, 278, 556, 500, 722, 500, 500, 500,
            334, 260, 334, 333, 1000, 278, 1000, 260, 1000, 333, 556, 556, 167,
            1000, 1000, 556, 1000, 556, 333, 333, 500, 500, 556, 1000, 1000,
            278, 1000, 350, 222, 333, 1000, 556, 1000, 1000, 611]),
          # CID:127～137のフォントは、333の幅
          127, 137, 333,
          # CID:140～配列長分のフォントは、配列のそれぞれの値の幅
          140, PdfArray.new([
            370, 556, 778, 1000, 365, 889, 278, 222, 611, 944, 611, 584, 737,
            584, 737, 1000, 1000, 333, 333, 556, 333, 834, 834, 834, 667, 667,
            667, 667, 667, 667, 722, 667, 667, 667, 667, 278, 278, 278, 278,
            722, 722, 778, 778, 778, 778, 778, 1000, 722, 722, 722, 722, 667,
            667, 556, 556, 556, 556, 556, 556, 500, 556, 556, 556, 556, 278,
            278, 278, 278, 556, 556, 556, 556, 556, 556, 556, 1000, 556, 556,
            556, 556, 500, 556, 500, 667, 667, 611, 556, 500, 1000, 500, 556]),
          231, 632, 500, 8718, 8719, 500])
        font_body = Font.new(
          :Subtype => :CIDFontType0,
          :BaseFont => "HeiseiKakuGo-W5".to_sym,
          :CIDSystemInfo => PdfDictionary.new({
            :Registry => "Adobe",
            :Ordering => "Japan1",
            :Supplement => 6}),
          :FontDescriptor => font_descriptor,
          :DW => 1000,
          :DW2 => PdfArray.new([880, -1000]),
          :W => w)
        @font_objects << font_body
        @main_object = Font.new(
          :Name => :jp_default,
          :Subtype => :Type0,
          :BaseFont => "HeiseiKakuGo-W5-UniJIS-UCS2-H".to_sym,
          :Encoding => "UniJIS-UCS2-H".to_sym,
          :DescendantFonts => PdfArray.new([font_body]))
        @font_objects << @main_object
        register
      end
    end
  end
end
