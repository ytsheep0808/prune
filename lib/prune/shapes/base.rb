# coding:utf-8
module Prune
  module Shapes
    class Base
      include Errors

      attr_accessor :id
      attr_accessor :x
      attr_accessor :y
      attr_accessor :width
      attr_accessor :height

      # Initialize.
      def initialize(page)
        @page = page
        @document = @page.document
        raise DuplicateIdError if @page.shape_ids.include?(id)
        @id = "shape_#{@page.shape_ids.size}".to_sym
        @x = 0.0
        @y = 0.0
        @width = 0.0
        @height = 0.0
      end

      # Render shapes.
      def render(stream)
        stream.each{|line| @page.stream << line}
        @page.shape_ids << @id
        @page.shapes.update(@id => self)
        self
      end

      private
      # Milli-meter to pt.
      def mm_to_pt(mm)
        Position.mm_to_pt(mm)
      end

      private
      # Convert to String.
      def to_s
        "Shape<#{@id}:#{self.class.to_s}>"
      end

      # Convert color string.
      def convert_color_str(color_str)
        raise ColorFormatError unless /\A#[0-9a-fA-F]{6}\z/ === color_str
        r = color_str[1, 2].to_i(16) / 255.0
        g = color_str[3, 2].to_i(16) / 255.0
        b = color_str[5, 2].to_i(16) / 255.0
        "%.2f %.2f %.2f" % [r, g, b]
      end
    end
  end
end
