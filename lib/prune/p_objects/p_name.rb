# coding:utf-8
module Prune
  module PObjects
    class PName < Base
      attr_reader :name
      
      # Initialize.
      def initialize(name)
        case name
        when String
          @name = "/" + name
        when Symbol
          @name = "/" + name.to_s
        else
          raise PNameTypeError
        end
        @name.freeze
      end

      # Calculate hash value for PName.
      def hash
        @name.hash
      end

      # Compare as a key of hash.
      def eql?(value)
        false if value.instance_of?(self.class)
        @name.eql?(value.name)
      end

      # Compare the value of string.
      def ==(value)
        false if value.instance_of?(self.class)
        @name == value.name
      end

      # Convert content to string.
      def to_s
        @name
      end
    end
  end
end
