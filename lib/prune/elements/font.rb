# coding:utf-8
module Prune 
  module Elements
    class Font < Base
      def initialize(document, options)
        super(document)
        @content = pd!(pn!(:Type) => pn!(:Font))
        @content.update(options)
        register
      end

      # Get name of the font.
      def name
        @content[pn!(:Name)]
      end

      # Set name of the font.
      def name=(name)
        @content[pn!(:Name)] = name
      end

      # Set base font.
      def base_font=(base_font)
        @content[pn!(:BaseFont)] = base_font
      end

      # Get encoding of the font.
      def encoding
        @content[pn!(:Encoding)]
      end
    end
  end
end
