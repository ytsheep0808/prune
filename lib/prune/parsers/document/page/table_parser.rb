# coding:utf-8
module Prune
  module Parsers
    # Parser for directive "table".
    class TableParser < Base
      attr_reader :page
      attr_reader :options

      # Initialize.
      def initialize(page, options = {})
        @page = page
        @options = options
        @x = @orig_x = @page.x
        @y = @orig_y = @page.y
        @width = 0.0
        @height = 0.0
      end

      protected
      # Tr tag.
      def tr(options = {}, &block)
        tr_parser = TrParser.new(self, @options.merge(options))
        tr_parser.instance_eval(&block)
        @page.x = @orig_x
        @page.y -= tr_parser.height
        tr_parser.render
      end
    end
  end
end
