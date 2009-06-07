# coding:utf-8
module Prune
  module Fonts
    # Helvetica font.
    class Helvetica < BaseEn
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
        @font_name = :helvetica
        self.name = self.class.key(options)
        if bold?(options) && italic?(options)
          self.base_font = pn!("Helvetica-BoldOblique")
        elsif bold?(options)
          self.base_font = pn!("Helvetica-Bold")
        elsif italic?(options)
          self.base_font = pn!("Helvetica-Oblique")
        else
          self.base_font = pn!(:Helvetica)
        end
      end
    end
  end
end
