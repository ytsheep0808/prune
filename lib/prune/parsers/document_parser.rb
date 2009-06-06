# coding:utf-8
module Prune
  module Parsers
    # Parser for Prune DSL.
    class DocumentParser < Base
      def initialize(document)
        @document = document
      end

      def properties(&block)
        @properties_parser = PropertiesParser.new(@document)
        @properties_parser.instance_eval(&block)
      end

      def page(size = :A4, options = {}, &block)
        @page_parser = PageParser.new(@document, size, options)
        @page_parser.instance_eval(&block)
      end
    end
  end
end
