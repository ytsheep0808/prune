# coding:utf-8
module Prune
  module Fonts
    # Symbol font.
    class Symbol < BaseEn
      class << self
        def key(options)
          FontOptionError if bold?(options) || italic?(options)
          PObjects.pn!(:symbol)
        end
      end

      def initialize(document, options = {})
        super(document)
        self.name = self.class.key(options)
        self.base_font = pn!(:Symbol)
      end
    end
  end
end
