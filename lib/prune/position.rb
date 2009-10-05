# coding:utf-8
module Prune
  class Position
    class << self
      # Define position.
      def [](x, y)
        self.new(x, y)
      end

      # Convert milli-meter to pt.
      def mm_to_pt(mm)
        pt = mm * 72.0 / 25.4
        (pt * 100.0).round / 100.0
      end
    end

    # Initialize.
    def initialize(x, y)
      @x = mm_to_pt(x)
      @y = mm_to_pt(y)
    end

    private
    # Convert milli-meter to pt.
    def mm_to_pt(mm)
      self.class.mm_to_pt(mm)
    end
  end
end
