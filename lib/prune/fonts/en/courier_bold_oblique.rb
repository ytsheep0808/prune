# coding:utf-8
module Prune 
  module Fonts
    class CourierBoldOblique < FontBase
      def initialize(pdf)
        super(pdf)
        @main_object = Font.new(
          :Name => :courier_bold_oblique,
          :Subtype => :Type1,
          :BaseFont => "Courier-BoldOblique".to_sym,
          :Encoding => :StandardEncoding)
        @font_objects << @main_object
        register
      end
    end
  end
end
