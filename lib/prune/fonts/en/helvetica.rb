# coding:utf-8
module Prune
  module Fonts
    class Helvetica < BaseEn
      class << self
        def key(options)
          bold, italic = flags(options)
          key = "helvetica"
          key << "_bold" if bold
          key << "_italic" if italic
          PObjects.pn!(key)
        end
      end

      def initialize(document, options = {})
        super(document)
        bold, italic = flags(options)
        self.name = self.class.key(options)
        if bold && italic
          self.base_font = pn!("Helvetica-BoldOblique")
        elsif bold
          self.base_font = pn!("Helvetica-Bold")
        elsif italic
          self.base_font = pn!("Helvetica-Oblique")
        else
          self.base_font = pn!(:Helvetica)
        end
      end
    end
  end
end
