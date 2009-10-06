# coding:utf-8
module Prune
  class Position
    include Errors

    attr_reader :x
    attr_reader :y

    class << self
      # Define position.
      def [](x, y)
        self.new(*x_y(x, y))
      end

      # Check and get x, y
      def x_y(x, y)
        [x, y].collect do |mm|
          raise InvalidPositionError unless mm.is_a?(Numeric)
          mm_to_pt(mm)
        end
      end

      # Convert milli-meter to pt.
      def mm_to_pt(mm)
        pt = mm * 72.0 / 25.4
        (pt * 100.0).round / 100.0
      end
    end

    # Initialize.
    def initialize(x, y)
      @x, @y = self.class.x_y(x, y)
    end

    # Plus.
    def +(position)
      raise InvalidPositionOperationError unless position.is_a?(Position)
      @x += position.x
      @y += position.y
    end

    # Update position.
    def update(x, y)
      @x, @y = self.class.x_y(x, y)
    end

    # Convert to Array.
    def to_a
      [@x, @y]
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
