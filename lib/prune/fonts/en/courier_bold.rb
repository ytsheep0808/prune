# coding:utf-8
module Prune 
  module Fonts
    class CourierBold < Base
      def initialize(pdf)
        super(pdf)
        @main_object = Font.new(
          :Name => :courier_bold,
          :Subtype => :Type1,
          :BaseFont => "Courier-Bold".to_sym,
          :Encoding => :StandardEncoding)
        @font_objects << @main_object
      end
    end
  end
end
