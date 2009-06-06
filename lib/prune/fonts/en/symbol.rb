# coding:utf-8
module Prune
  module Fonts
    class Symbol < BaseEn
      class << self
        def key(options)
          bold, italic = flags(options)
          FontOptionError if bold || italic
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
