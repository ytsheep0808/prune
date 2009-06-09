# coding:utf-8
module Prune 
  module Fonts
    # Courier font.
    class Courier < BaseEn
      class << self
        def key(options)
          key = font_name
          key << "_bold" if bold?(options)
          key << "_italic" if italic?(options)
          PObjects.pn!(key)
        end
      end

      def initialize(document, options = {})
        super(document)
        self.name = self.class.key(options)
        if bold?(options) && italic?(options)
          self.base_font = pn!("Courier-BoldOblique")
        elsif bold?(options)
          self.base_font = pn!("Courier-Bold")
        elsif italic?(options)
          self.base_font = pn!("Courier-Oblique")
        else
          self.base_font = pn!(:Courier)
        end
      end

      # Get width of the text.
      def width(string, height)
        string.size * 600 * height / 1000
      end
    end
  end
end
