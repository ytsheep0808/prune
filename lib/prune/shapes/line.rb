# coding:utf-8
module Prune
  module Shapes
    class Line < Base
      # Draw line.
      def initialize(page, from, to, options = {})
        super(page)
        # Check arguments.
        raise LineArgumentError unless from.is_a?(Position)
        raise LineArgumentError unless to.is_a?(Position)
        # Set instance variables.
        @id = options[:id] if options.key?(:id)
        @x = from.x
        @y = from.y
        @width = from.x + to.x
        @height = from.y - to.y
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
        stream = []
        stream << "q"
        case @style
        when :solid
          stream << "[] 0 d"
        when :dashed
          stream << "[5 5] 0 d"
        else
          raise LineStyleError
        end
        stream << "2 J"
        stream << "0 j"
        stream << "%s RG" % convert_color_str(@color)
        stream << "%.2f w" % width
        stream << "%.2f %.2f m" % [@x, @y]
        stream << "%.2f %.2f l" % [@width, @height]
        stream << "s"
        stream << "Q"
        super(stream)
      end
    end
  end
end
