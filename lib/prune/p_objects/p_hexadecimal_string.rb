# coding:utf-8

module Prune
  module PObjects
    class PHexadecimalString < Base
      def initialize(string)
        raise unless string.instance_of?(String)
        @string = string
      end

      def string
        @string
      end

      def equal?(value)
        false unless value.instance_of?(self.class)
        @string.equal?(value.string)
      end

      def ==(value)
        false unless value.instance_of?(self.class)
        @string == value.string
      end

      def to_s
        "<#{@string}>"
      end
    end
  end
end
