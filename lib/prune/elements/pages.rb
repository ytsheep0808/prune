# coding:utf-8

require "elements/base"

module Prune 
  module Elements
    class Pages < Base
      def initialize(pdf)
        super(pdf)
        @content = PdfDictionary.new({
          :Type => :Pages,
          :Kids => PdfArray.new([]),
          :Count => 0})
        register
      end

      def parent=(parent)
        @content.update(:Parent => parent)
      end

      def empty?
        @content[:Kids].empty?
      end

      def <<(page)
        raise MalFormedPageError unless page.instance_of?(Page)
        @content[:Kids] << page
        @content[:Count] += 1
      end

      def page(no)
        raise UnknownPageError unless
          ((1 <= no) && (no <= @content[:Kids].size))
        @content[:Kids][no - 1]
      end
    end
  end
end
