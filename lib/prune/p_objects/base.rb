# coding:utf-8

require "pdf_errors"

module Prune
  # alias for PArray.new
  def pa!(*args)
    PObjects::PArray.new(*args)
  end

  # alias for PDictionary.new
  def pd!(hash = {})
    PObjects::PDictionary.new(hash)
  end

  # alias for PHexadecimalString.new
  def ph!(string)
    PObjects::PHexadecimalString.new(string)
  end

  # alias for PLiteralString.new
  def pl!(string)
    PObjects::PLiteralString.new(string)
  end

  # alias for PName.new
  def pn!(name)
    PObjects::PName.new(name)
  end

  # alias for PStream.new
  def ps!
    PObjects::PStream.new
  end

  module PObjects
    class Base
      # インデント
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
