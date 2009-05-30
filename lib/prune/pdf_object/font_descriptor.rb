# coding:utf-8

require "pdf_object/base_object"

module RubyPdfBuilder
  module PdfObject
    class FontDescriptor < BaseObject
      def initialize(hash)
        super(nil)
        @content = PdfDictionary.new({:Type => :FontDescriptor})
        @content.update(hash)
      end
    end
  end
end
