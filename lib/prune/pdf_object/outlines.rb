# coding:utf-8

require "pdf_object/base_object"

module RubyPdfBuilder
  module PdfObject
    class Outlines < BaseObject
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
