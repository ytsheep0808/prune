# coding:utf-8
module Prune
  module Parsers
    # Parser for directive "tr".
    class TrParser < Base
      attr_reader :x
      attr_reader :y
      attr_reader :width
      attr_reader :height

      # Initialize.
      def initialize(table, options = {})
        @table = table
        @options = options
        # Boundary of this object.
        @x = @table.page.x
        @y = @table.page.y
        @width = 0.0
        @height = 0.0
        # All td tags inside this tag.
        @tds = []
      end

      # Render td tags.
      def render
        @tds.each do |td|
          # Set td height to highest.
          td.height = @height
          td.render
        end
      end

      protected
      # Td tag.
      def td(string, options = {})
        td = Shapes::TextBox.new(@table.page, string, @options.merge(options))
        # Set width and height for tr tag.
        @width += td.width
        @height = td.height if @height < td.height
        @tds << td
        @table.page.x += td.width
        td
      end
    end
  end
end
