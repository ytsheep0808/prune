# coding:utf-8
module Prune
  module PObjects
    module_function
    # Alias for PArray.new
    def pa(*args)
      PArray.new(*args)
    end

    # Alias for PDictionary.new
    def pd(hash = {})
      PDictionary.new(hash)
    end

    # Alias for PHexadecimalString.new
    def ph(string)
      PHexadecimalString.new(string)
    end

    # Alias for PLiteralString.new
    def pl(string)
      PLiteralString.new(string)
    end

    # Alias for PName.new
    def pn(name)
      PName.new(name)
    end

    # Alias for PStream.new
    def ps
      PStream.new
    end
  end
end
