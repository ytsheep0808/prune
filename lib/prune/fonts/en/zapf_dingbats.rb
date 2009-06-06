# coding:utf-8
module Prune
  module Fonts
    class ZapfDingbats < BaseEn
      class << self
        def key(options)
          bold, italic = flags(options)
          FontOptionError if bold || italic
          PObjects.pn!(:zapf_dingbats)
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
