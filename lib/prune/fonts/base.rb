# coding:utf-8

module Prune 
  module Fonts
    class Base
      include Elements

      def initialize(document)
        @document = document
        @font_objects = []
        @main_object = nil
      end

      def reference
        @main_object.reference
      end
    end
  end
end
