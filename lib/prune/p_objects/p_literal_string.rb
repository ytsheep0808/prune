# coding:utf-8
module Prune
  module PObjects
    class PLiteralString < Base
      attr_reader :string
      
      def initialize(string)
        raise PLiteralStringTypeError unless
          string.instance_of?(String)
        @string = string
      end

      def ==(value)
        false unless value.instance_of?(self.class)
        @string == value.string
      end

      def to_s
        "(#{@string})"
      end
    end
  end
end
