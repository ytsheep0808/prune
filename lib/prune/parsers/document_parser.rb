# coding:utf-8

require "parsers/document/properties_parser"

module Prune
  module Parsers
    # parser for Prune DSL
    class DocumentParser
      def initialize(document)
        @document = document
        @properties_parser = PropertiesParser.new(@document)
      end

      def properties(&block)
        puts self.class.to_s + ".properties"
        @properties_parser.instance_eval(&block)
      end
    end
  end
end
