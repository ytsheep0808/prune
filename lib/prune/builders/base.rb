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
    end
  end
end
