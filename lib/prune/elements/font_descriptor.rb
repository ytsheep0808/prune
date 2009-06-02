# coding:utf-8

require "elements/base"

module Prune 
  module Elements
    class FontDescriptor < Base
      def initialize(hash)
        super(nil)
        @content = PdfDictionary.new({:Type => :FontDescriptor})
        @content.update(hash)
      end
    end
  end
end
