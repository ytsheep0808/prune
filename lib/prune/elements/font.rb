# coding:utf-8
module Prune 
  module Elements
    class Font < Base
     def initialize(document, options)
        super(document)
        @name = options[pn!(:Name)]
        @content = pd!(pn!(:Type) => pn!(:Font))
        @content.update(options)
        register
      end

      def encoding
        @content[:Encoding]
      end
    end
  end
end
