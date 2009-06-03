# coding:utf-8

module Prune 
  module Elements
    class FontDescriptor < Base
      include Prune

      def initialize(hash)
        super(nil)
        @content = pd!(pn!(:Type) => pn!(:FontDescriptor))
        @content.update(hash)
      end
    end
  end
end
