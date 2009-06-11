# coding:utf-8
require "kconv"

module Prune 
  module Fonts
    # Base class for Japanese fonts.
    class BaseJa < Base
      unless const_defined?(:HALF_SIZED_CHARS)
        HALF_SIZED_CHARS = (
          # CID:1 to 95.
          %W[
            ! " # $ % & ' ( ) * + , - . / 0 1 2 3 4
            5 6 7 8 9 : ; < = > ? @ A B C D E F G H
            I J K L M N O P Q R S T U V W X Y Z \[ \\
            \] ^ _ ` a b c d e f g h i j k l m n o p
            q r s t u v w x y z { | } ~
          ] + [' ']).collect{|char| char.toutf16}
      end

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
          # Widths for fonts from CID:1 to 95 should be half sized.
          1, pa!(
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500),
          # Widths for fonts from CID:327 to 389 should be half sized.
          327, pa!(
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500, 500, 500, 500, 500, 500, 500, 500,
            500, 500, 500))
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
            # Default width.
            pn!(:DW) => 1000,
            # Default width for vertical writing.
            pn!(:DW2) => pa!(880, -1000),
            # Widths.
            pn!(:W) => w))
        # Main element.
        @main_element = Font.new(
          document,
          pd!(
            pn!(:Subtype) => pn!(:Type0),
            pn!(:Encoding) => pn!("UniJIS-UCS2-H"),
            pn!(:DescendantFonts) => pa!(@body_element.reference)))
      end

      # Decode string.
      def decode(string)
        ph!(string.toutf16.unpack("C*").collect{|c| "%02X" % c}.join)
      end

      # Get width of the text.
      def width(string, font_size)
        bytes = string.toutf16.bytes
        width = 0
        bytes.each_slice(2) do |char_bytes|
          char = char_bytes.pack("C2")
          if HALF_SIZED_CHARS.include?(char)
            width += 500
          else
            width += 1000
          end
        end
        width * font_size / 1000
      end

      private
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
