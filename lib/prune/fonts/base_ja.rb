# coding:utf-8
module Prune 
  module Fonts
    # Base class for Japanese fonts.
    class BaseJa < Base
      def initialize(document)
        super(document)
        # Font descriptor element.
        @descriptor_element = FontDescriptor.new(
          document,
          pd!(
            pn!(:Ascent) => 859,
            pn!(:Descent) => -140,
            pn!(:CapHeight) => 769,
            pn!(:MissingWidth) => 500,
            pn!(:FontBBox) => pa!(0, -136, 1000, 859)))
        # Font widths.
        w = pa!(
          # Widths for fonts after CID:1 should be widths written in array.
          1, pa!(
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500),
          # Widths for fonts after CID:231 should be widths written in array.
          231, pa!(
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500),
          # Widths for fonts after CID:327 should be widths written in array.
          327, pa!(
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500),
          # Widths for fonts after CID:631 should be widths written in array.
          631, pa!(500))
        # Font body element.
        @body_element = Font.new(
          document,
          pd!(
            pn!(:Subtype) => pn!(:CIDFontType0),
            pn!(:CIDSystemInfo) => pd!(
              pn!(:Registry) => pl!("Adobe"),
              pn!(:Ordering) => pl!("Japan1"),
              pn!(:Supplement) => 2),
            pn!(:FontDescriptor) => @descriptor_element.reference,
            pn!(:DW) => 1000,
            pn!(:DW2) => pa!(880, -1000),
            pn!(:W) => w))
        # Main element.
        @main_element = Font.new(
          document,
          pd!(
            pn!(:Subtype) => pn!(:Type0),
            pn!(:Encoding) => pn!("UniJIS-UCS2-H"),
            pn!(:DescendantFonts) => pa!(@body_element.reference)))
      end

      # Set font name.
      def name=(name)
        @main_element.name = name
      end

      # Set base font.
      def base_font=(base_font)
        @main_element.base_font = base_font
        @body_element.base_font = base_font
        @descriptor_element.font_name = base_font
      end
      
      # Set italic angle.
      def italic_angle=(angle)
        @descriptor_element.italic_angle = angle
      end

      # Set flags.
      def flags=(flags)
        @descriptor_element.flags = flags
      end

      # Set stem v.
      def stem_v=(stem_v)
        @descriptor_element.stem_v = stem_v
      end
    end
  end
end
