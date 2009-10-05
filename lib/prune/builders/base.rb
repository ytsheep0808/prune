# coding:utf-8
module Prune
  module Builders
    class Base
      include Errors

      # Initialize
      def initialize(page)
        @page = page
        @stream = @page.stream
      end

      private
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
