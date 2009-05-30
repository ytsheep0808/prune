# coding:utf-8

require "pdf_handler/base_handler"
require "pdf_errors"

module RubyPdfBuilder
  module PdfHandler
    class DrawHandler < BaseHandler
      LINE_CAP = {
        :butt_cap => 0,
        :round_cap => 1,
        :projecting_square_cap => 2
      }.freeze

      def set_line_color(color = [255, 255, 255])
        unless color.is_a?(Array) && color.size == 3
          raise ColorFormatError
        end
        @stream << "%f %f %f RG" % color.collect{|rgb| rgb / 255.0}
      end

      def set_fill_color(color = [255, 255, 255])
        unless color.is_a?(Array) && color.size == 3
          raise ColorFormatError
        end
        @stream << "%f %f %f rg" % color.collect{|rgb| rgb / 255.0}
      end

      def set_line_width(width)
        @stream << "%f w" % width
      end

      def set_line_cap(cap)
        if LINE_CAP.keys.include?(cap)
          @stream << "%s J" % LINE_CAP[cap]
        end
      end

      def move(pos)
        @stream << "%f %f m" % [pos[0], trans_y(pos[1])]
      end

      def line_to(pos)
        @stream << "%f %f l" % [pos[0], trans_y(pos[1])]
      end

      def fill
        @stream << "f"
      end

      def stroke
        @stream << "S"
      end

      def draw_line(pos1, pos2, width = 0.5, color = [0,0,0])
        @stream << "q"
        set_line_color(color)
        set_line_width(width)
        move(pos1)
        line_to(pos2)
        stroke
        @stream << "Q"
      end
    end
  end
end
