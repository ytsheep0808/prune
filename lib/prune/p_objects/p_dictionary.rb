# coding:utf-8

module Prune
  module PObjects
    class PDictionary < Base
      include Prune

      def initialize(hash = {})
        raise unless hash.keys.all?{|key|
          key.instance_of?(PName)
        }
        @hash = hash
      end

      def empty?
        return @hash.empty?
      end

      def [](key)
        @hash[key]
      end

      def []=(key, value)
        raise unless key.instance_of?(PName)
        @hash[key] = value
      end

      def update(hash)
        raise unless hash.keys.all?{|key|
          key.instance_of?(PName)
        }
        @hash.update(hash)
      end

      def has_key?(key)
        @hash.has_key?(key)
      end

      def keys
        keys = @hash.keys.sort_by{|key| key.to_s}
        keys.unshift(pn!(:Type)) if keys.delete(pn!(:Type))
        keys
      end

      def size
        @hash.size
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
