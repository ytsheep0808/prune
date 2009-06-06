# coding:utf-8
module Prune 
  module Handlers
    class TableHandler < Base
      attr_accessor :height

      def initialize(page, widths, pos)
        super(page)
        @height = page.font_size + 2
        @widths = widths
        @x, @y = pos
        @draw = DrawHandler.new(page)
        @text = TextHandler.new(page)
        @table_width = widths.inject(0){|sum, width| sum + width}
        # Draw a horizontal line
        draw_table_line
      end

      # Write columns.
      def cols(cols)
        raise TableFormatError unless cols.is_a?(Array)
        raise TableFormatError unless cols.size == @widths.size
        # Calculate highest column.
        line_feeds = 0
        cols.each{|col|
          count = col.count("\n")
          line_feeds = count if count > line_feeds
        }
        col_height = @height * (line_feeds + 1)
        x = @x
        # Draw each columns.
        @widths.each_with_index{|width, index|
          # Draw a vertical line.
          @draw.draw_line([x, @y], [x, @y + col_height])
          # Write text.
          @text.write(cols[index], @page.font, @page.font_size, [x + 2, @y])
          x += width
        }
        # Draw a vertical line.
        @draw.draw_line([x, @y], [x, @y + col_height])
        # Update y value.
        @y += col_height
        # Draw a horizontal line.
        draw_table_line
      end

      private
      def draw_table_line
        @draw.draw_line([@x, @y], [@x + @table_width, @y])
      end
    end
  end
end
