# coding:utf-8
module Prune
  module Fonts
    # Base class for English fonts.
    class BaseEn < Base
      # Initialize.
      def initialize(document)
        super(document)
        @main_object = Font.new(
          document,
          pd!(
            pn!(:Subtype) => pn!(:Type1),
            pn!(:Encoding) => pn!(:StandardEncoding)))
        @font_objects << @main_object
      end

      # Set font name.
      def name=(name)
        @main_object.name = name
      end

      # Set base_font.
      def base_font=(base_font)
        @main_object.base_font = base_font
      end
    end
  end
end
