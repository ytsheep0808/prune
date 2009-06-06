# coding:utf-8
module Prune
  module PObjects
    module_function
    # Alias for PArray.new
    def pa!(*args)
      PArray.new(*args)
    end

    # Alias for PDictionary.new
    def pd!(hash = {})
      PDictionary.new(hash)
    end

    # Alias for PHexadecimalString.new
    def ph!(string)
      PHexadecimalString.new(string)
    end

    # Alias for PLiteralString.new
    def pl!(string)
      PLiteralString.new(string)
    end

    # Alias for PName.new
    def pn!(name)
      PName.new(name)
    end

    # Alias for PStream.new
    def ps!
      PStream.new
    end

    class Base
      include Errors
      include PObjects

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
          # if value.respond_to?(:reference_id)
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
