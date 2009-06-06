# coding:utf-8
module Prune 
  module Fonts
    class HelveticaBold < Base
      def initialize(document)
        super(document)
        @main_object = Font.new(
          document,
          pd!(
            pn!(:Name) => pn!(:helvetica_bold),
            pn!(:Subtype) => pn!(:Type1),
            pn!(:BaseFont) => pn!("Helvetica-Bold") ,
            pn!(:Encoding) => pn!(:StandardEncoding)))
        @font_objects << @main_object
      end
    end
  end
end
