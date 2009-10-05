# coding:utf-8
module Prune
  module PObjects
    class Base
      include Errors

      # Indent.
      @@indent = 0

      def space
        "  " * @@indent
      end

      def indent!
        @@indent += 1
      end

      def outdent!
        @@indent -= 1
      end

      def value_to_s(value)
        case value
        when String
          return value
        when PName, PLiteralString, PHexadecimalString
          return value.to_s
        when PArray, PDictionary
          indent!
          out = LF + space + value.to_s
          outdent!
          return out
        else
          if value.is_a?(Prune::Elements::Base)
            return value.reference_id
          else
            return value.to_s
          end
        end
      end
    end
  end
end
