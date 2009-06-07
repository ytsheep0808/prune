# coding:utf-8
module Prune
  module Fonts
    # Zapf dingbats font.
    class ZapfDingbats < BaseEn
      class << self
        def key(options)
          FontOptionError if bold?(options) || italic?(options)
          PObjects.pn!(font_name)
        end
      end

      def initialize(document, options = {})
        super(document)
        self.name = self.class.key(options)
        self.base_font = pn!(:ZapfDingbats)
      end
    end
  end
end
