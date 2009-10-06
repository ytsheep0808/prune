# coding:utf-8
module Prune
  module Shapes
    class Rectangle < Base
      STYLES = {
        :solid => "[] 0 d",
        :dashed => "[5 5] 0 d"
      } unless const_defined?(:STYLES)

      # Draw rectangle.
      def initialize(page, boundary, options = {})
        super(page)
        # Set instance variables.
        @id = options[:id] if options.key?(:id)
        @x = boundary[0]
        @y = boundary[1]
        @width = boundary[2]
        @height = boundary[3]
        @options = options
        # Parse options.
        @style = options[:style] || :none
        @border_width = options[:border_width] || 1.0
        @border_color = options[:border_color] || "#000000"
        @fill = options[:fill] || false
        @fill_color = options[:fill_color] || "#000000"
      end

      # Render shape.
      def render
        stream = []
        boundary = [@x, @y, @width, -@height]
        stream << "q"
        # Set fill color.
        if @fill
          stream << "%s rg" % convert_color_str(@fill_color)
          stream << "%.2f %.2f %.2f %.2f re" % boundary
          stream << "f"
        end
        # Draw boundary.
        unless @style == :none
          raise LineStyleError unless STYLES.include?(@style)
          stream << STYLES[@style]
          stream << "2 J"
          stream << "0 j"
          stream << "%s RG" % convert_color_str(@border_color)
          stream << "%.2f w" % @width
          stream << "%.2f %.2f %.2f %.2f re" % boundary
          stream << "s"
        end
        stream << "Q"
        super(stream)
      end
    end
  end
end
