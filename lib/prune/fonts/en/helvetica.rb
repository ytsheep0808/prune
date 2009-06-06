# coding:utf-8
module Prune 
  module Fonts
    class Helvetica < Base
      def initialize(document)
        super(document)
        @main_object = Font.new(
          document,
          pn!(
            pn!(:Name) => pn!(:helvetica),
            pn!(:Subtype) => pn!(:Type1),
            pn!(:BaseFont) => pn!(:Helvetica),
            pn!(:Encoding) => pn!(:StandardEncoding)))
        @font_objects << @main_object
      end
    end
  end
end
