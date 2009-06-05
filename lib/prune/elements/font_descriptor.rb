# coding:utf-8
module Prune 
  module Elements
    class FontDescriptor < Base
      def initialize(document, options)
        super(document)
        @content = pd!(pn!(:Type) => pn!(:FontDescriptor))
        @content.update(options)
        register
      end
    end
  end
end
