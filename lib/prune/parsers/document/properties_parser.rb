# coding:utf-8
module Prune
  module Parsers
    # Parser for directive "properties".
    class PropertiesParser < Base
      # Initialize.
      def initialize(document)
        @document = document
      end

      # Send block to DescriptionParser class.
      def description(&block)
        puts self.class.to_s + ".description"
        @description_parser = DescriptionParser.new(@document)
        @description_parser.instance_eval(&block)
      end
    end
  end
end
