# coding:utf-8
module Prune
  module Fonts
    # Base class for English fonts.
    class BaseEn < Base
      # Initialize.
      def initialize(document)
        super(document)
        @main_element = Font.new(
          document,
          pd!(
            pn!(:Subtype) => pn!(:Type1),
            pn!(:Encoding) => pn!(:StandardEncoding)))
      end

      # Set font name.
      def name=(name)
        @main_element.name = name
      end

      # Set base_font.
      def base_font=(base_font)
        @main_element.base_font = base_font
      end
    end
  end
end
