# coding:utf-8
module Prune
  module PObjects
    class PHexadecimalString < Base
      attr_reader :string
      
      def initialize(string)
        raise PHexadecimalStringTypeError unless
          string.instance_of?(String)
        @string = string.upcase
        raise PHexadecimalStringContentError unless
          /[0-9A-F]+/ === @string
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
