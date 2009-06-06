# coding:utf-8
module Prune 
  module Fonts
    class MsGothic < BaseJa
      class << self
        def key(options)
          key = "courier"
          key << "_bold" if bold?(options)
          key << "_italic" if italic?(options)
          PObjects.pn!(key)
        end
      end

      def initialize(document, options = {})
        super(document)
        self.name = self.class.key(options)
        if bold?(options) && italic?(options)
          self.base_font = pn!("MS-Gothic")
          self.flags = 262213
          self.italic_angle = -11
          self.stem_v = 156
        elsif bold?(options)
          self.base_font = pn!("MS-Gothic,Bold")
          self.flags = 262149
          self.italic_angle = 0
          self.stem_v = 156
        elsif italic?(options)
          self.base_font = pn!("MS-Gothic,Italic")
          self.flags = 69
          self.italic_angle = -11
          self.stem_v = 78
        else
          self.base_font = pn!("MS-Gothic")
          self.flags = 5
          self.italic_angle = 0
          self.stem_v = 78
        end
      end
    end
  end
end
