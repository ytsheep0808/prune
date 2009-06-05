# coding:utf-8

require "parsers/document/properties/description_parser"

module Prune
  module Parsers
    # parser for directive "properties"
    class PropertiesParser
      # initialize
      def initialize(document)
        @document = document
      end

      # send block to DescriptionParser class
      def description(&block)
        puts self.class.to_s + ".description"
        @description_parser = DescriptionParser.new(@document)
        @description_parser.instance_eval(&block)
      end
    end
  end
end
