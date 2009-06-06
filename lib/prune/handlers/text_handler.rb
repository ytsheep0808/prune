# coding:utf-8
require "kconv"

module Prune 
  module Handlers
    class TextHandler < Base
      def write(text, font, font_size, pos)
        @font = font.main_object
        text.split("\n").each_with_index{|token, index|
          decoded_text = decode(token)
          y = trans_y(pos[1] + font_size * (index + 1))
          @stream << "BT"
          @stream << "/%s %d Tf" % [@font.name.to_s, font_size]
          @stream << "%d %d Td" % [pos[0], y]
          @stream << "%s Tj" % decoded_text
          @stream << "ET"
        }
      end

      private
      def decode(text)
        case @font.encoding
        when :StandardEncoding
          "(%s)" % text
        when "UniJIS-UCS2-H".to_sym
          "<%s>" % text.toutf16.unpack("C*").collect{|c| "%02X" % c}.join("")
        else
          raise UnknownEncodingError
        end
      end
    end
  end
end
