# coding:utf-8

require "pdf_object/base_object"

module RubyPdfBuilder
  module PdfObject
    class Font < BaseObject
      attr_reader :name
      attr_reader :content

      def initialize(hash)
        super(nil)
        @name = hash[:Name]
        @content = PdfDictionary.new({:Type => :Font})
        @content.update(hash)
      end

      def encoding
        @content[:Encoding]
      end
    end
  end
end
