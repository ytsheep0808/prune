# coding:utf-8
module Prune
  module Fonts
    class TimesRoman < BaseEn
      class << self
        def key(options)
          bold, italic = flags(options)
          key = "times_roman"
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
          self.base_font = pn!("Times-BoldItalic")
        elsif bold
          self.base_font = pn!("Times-Bold")
        elsif italic
          self.base_font = pn!("Times-Italic")
        else
          self.base_font = pn!("Times-Roman")
        end
      end
    end
  end
end
