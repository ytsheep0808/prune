# coding:utf-8

module Prune
  module PObjects
    class PName < PObject
      def initialize(name)
        case name
        when String
          @name = name
        when Symbol
          @name = name.to_s
        end
      end
    end
  end
end
