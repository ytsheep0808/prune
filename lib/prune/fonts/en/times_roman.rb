# coding:utf-8
module Prune
  module Fonts
    # Times Roman font.
    class TimesRoman < BaseEn
      class << self
        def key(options)
          key = "times_roman"
          key << "_bold" if bold?(options)
          key << "_italic" if italic?(options)
          PObjects.pn!(key)
        end
      end

      def initialize(document, options = {})
        super(document)
        self.name = self.class.key(options)
        if bold?(options) && italic?(options)
          self.base_font = pn!("Times-BoldItalic")
        elsif bold?(options)
          self.base_font = pn!("Times-Bold")
        elsif italic?(options)
          self.base_font = pn!("Times-Italic")
        else
          self.base_font = pn!("Times-Roman")
        end
      end
    end
  end
end
