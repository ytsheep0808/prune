# coding:utf-8
module Prune
  class Position
    include Errors

    attr_reader :x
    attr_reader :y

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
      raise InvalidPositionError unless x.is_a?(Numeric)
      raise InvalidPositionError unless y.is_a?(Numeric)
      @x = mm_to_pt(x)
      @y = mm_to_pt(y)
    end

    # Plus.
    def +(position)
      raise InvalidPositionOperationError unless position.is_a?(self)
      @x += position.x
      @y += position.y
    end

    # Convert to String.
    def to_s
      "%.2f %.2f" % [@x, @y]
    end

    private
    # Convert milli-meter to pt.
    def mm_to_pt(mm)
      self.class.mm_to_pt(mm)
    end
  end
end
