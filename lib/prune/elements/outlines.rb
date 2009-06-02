# coding:utf-8

require "elements/base"

module Prune 
  module Elements
    class Outlines < Base
      def initialize(pdf)
        super(pdf)
        @content = PdfDictionary.new({
          :Type => :Outlines,
          :Count => 0})
        register
      end
    end
  end
end
