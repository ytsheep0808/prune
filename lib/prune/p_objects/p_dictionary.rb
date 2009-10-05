# coding:utf-8
module Prune
  module PObjects
    class PDictionary < Base
      attr_reader :dict

      def initialize(pd = {})
        @dict = {}
        @dict.update(pd)
      end

      def empty?
        return @dict.empty?
      end

      def [](key)
        @dict[key]
      end

      def []=(key, value)
        self.update(key => value)
      end

      def update(pd)
        case pd
        when PDictionary
          raise PDictionaryKeyError unless pd.keys.all?{|key|
            key.instance_of?(PName)
          }
          @dict.update(pd.dict)
        when Hash
          raise PDictionaryKeyError unless pd.keys.all?{|key|
            key.instance_of?(PName)
          }
          @dict.update(pd)
        else
          raise PDictionaryTypeError
        end
      end

      def has_key?(key)
        @dict.has_key?(key)
      end

      def keys
        keys = @dict.keys.sort_by{|key| key.to_s}
        type_key = PName.new(:Type)
        keys.unshift(type_key) if keys.delete(type_key)
        keys
      end

      def size
        @dict.size
      end

      def to_s
        case self.size
        when 0
          "<< >>"
        when 1
          "<< %s >>" % pair_to_s(self.keys.first)
        else
          out = []
          out << "<<"
          indent!
          self.keys.each{|key|
            out << space + pair_to_s(key)
          }
          outdent!
          out << space + ">>"
          out.join(LF)
        end
      end

      private
      def pair_to_s(key)
        "%s %s" % [value_to_s(key), value_to_s(self[key])]
      end
    end
  end
end
