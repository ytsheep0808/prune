# coding:utf-8
module Prune 
  module Elements
    class FontDescriptor < Base
      def initialize(document, options)
        super(document)
        @content = pd!(pn!(:Type) => pn!(:FontDescriptor))
        @content.update(options)
        register
      end

      # Set font name.
      def font_name=(name)
        @content[pn!(:FontName)] = name
      end

      # Set italic angle.
      def italic_angle=(angle)
        @content[pn!(:ItalicAngle)] = angle
      end

      # Set flags.
      def flags=(flags)
        @content[pn!(:Flags)] = flags
      end

      # Set stem v.
      def stem_v=(stem_v)
        @content[pn!(:StemV)] = stem_v
      end
    end
  end
end
