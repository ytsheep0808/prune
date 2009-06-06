# coding:utf-8
module Prune 
  module Handlers
    class Base
      include Errors
      
      attr_reader :lines

      def initialize(page)
        @page = page
        @stream = page.stream
      end

      # Y座標変換
      def trans_y(y)
        @page.height - y
      end
    end
  end
end
