# coding:utf-8
module Prune
  module Builders
    class ShapeBuilder < Base
      # Draw line.
      def draw_line(from, to, options = {})
        # Check arguments.
        raise ShapeArgumentError unless from.is_a?(Position)
        raise ShapeArgumentError unless to.is_a?(Position)
        # Parse options.
        style = options[:style] || :none
        width = options[:width] || 1.0
        color = options[:color] || "#000000"
        return if style == :none
        # Set style.
        set_style(style)
        # Draw line.
        @stream << "2 J"
        @stream << "0 j"
        @stream << "%s RG" % convert_color_str(color)
        @stream << "%.2f w" % width
        @stream << "%s m" % from
        @stream << "%s l" % to
        @stream << "s"
      end

      # Draw rectangle.
      def draw_rect(pos, width, height, options = {})
        # Check arguments.
        raise ShapeArgumentError unless pos.is_a?(Position)
        raise ShapeArgumentError unless width.is_a?(Numeric)
        raise ShapeArgumentError unless height.is_a?(Numeric)
        # Parse options.
        style = options[:style] || :none
        width = options[:width] || 1.0
        fill = options[:fill] || false
        border_color = options[:border_color] || "#000000"
        fill_color = options[:fill_color] || "#000000"
        return if style == :none
        # Set style.
        set_style(style)
        # Draw rectangle.
        boundary = [pos.x, pos.y, width, -height]
        if fill
          @stream << "%s rg" %
            convert_color_str(fill_color)
          @stream << "%.2f %.2f %.2f %.2f re" % boundary
          @stream << "f"
        end
        @stream << "2 J"
        @stream << "0 j"
        @stream << "%s RG" %
          convert_color_str(border_color)
        @stream << "%.2f w" % width
        @stream << "%.2f %.2f %.2f %.2f re" % boundary
        @stream << "s"
      end

      private
      # Set style.
      def set_style(style)
        case style
        when :solid
          @stream << "[] 0 d"
        when :dashed
          @stream << "[5 5] 0 d"
        else
          raise ShapeOptionError
        end
      end
    end
  end
end
