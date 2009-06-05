# coding:utf-8

module Prune 
  module Fonts
    class Courier < Base
      include Prune

      def initialize(document)
        super(document)
        @main_object = Font.new(
          document,
          pd!(
            pn!(:Name) => pn!(:courier),
            pn!(:Subtype) => pn!(:Type1),
            pn!(:BaseFont) => pn!(:Courier),
            pn!(:Encoding) => pn!(:StandardEncoding)))
        @font_objects << @main_object
      end
    end
  end
end
