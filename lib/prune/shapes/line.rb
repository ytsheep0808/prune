# coding:utf-8
module Prune
  module Shapes
    class Line < Base
      STYLES = {
        :solid => "[] 0 d",
        :dashed => "[5 5] 0 d"
      } unless const_defined?(:STYLES)

      # Draw line.
      def initialize(page, from_x, from_y, to_x, to_y, options = {})
        super(page)
        # Check arguments.
        raise LineArgumentError unless from_x.is_a?(Numeric)
        raise LineArgumentError unless from_y.is_a?(Numeric)
        raise LineArgumentError unless to_x.is_a?(Numeric)
        raise LineArgumentError unless to_y.is_a?(Numeric)
        # Set instance variables.
        @id = options[:id] if options.key?(:id)
        @x = from_x
        @y = from_y
        @to_x = to_x
        @to_y = to_y
        @width = to_x - from_x
        @height = -(to_y - from_y)
        @options = options
        # Parse options.
        @style = options[:style] || :none
        @width = options[:width] || 1.0
        @color = options[:color] || "#000000"
      end

      # Render shape.
      def render
        return [] if @style == :none
        return [] if @width <= 0.0
        raise LineStyleError unless STYLES.include?(@style)
        stream = []
        stream << "q"
        stream << "2 J"
        stream << "0 j"
        stream << STYLES[@style]
        stream << "%s RG" % convert_color_str(@color)
        stream << "%.2f w" % width
        stream << "%.2f %.2f m" % [@x, @y]
        stream << "%.2f %.2f l" % [@to_x, @to_y]
        stream << "s"
        stream << "Q"
        super(stream)
      end
    end
  end
end
