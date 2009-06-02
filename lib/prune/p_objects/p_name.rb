# coding:utf-8

module Prune
  module PObjects
    class PName < Base
      def initialize(name)
        case name
        when String
          @name = "/" + name
        when Symbol
          @name = "/" + name.to_s
        else
          raise
        end
        @name.freeze
      end

      def name
        @name
      end

      def hash
        @name.hash
      end

      def eql?(value)
        false if value.instance_of?(self.class)
        @name.eql?(value.name)
      end

      def equal?(value)
        false if value.instance_of?(self.class)
        @name.equal?(value.name)
      end

      def ==(value)
        false if value.instance_of?(self.class)
        @name == value.name
      end

      def to_s
        @name
      end
    end
  end
end
