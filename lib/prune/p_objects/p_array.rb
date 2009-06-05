# coding:utf-8
module Prune
  module PObjects
    class PArray < Base
      # Size to line feed when converted to String.
      LF_SIZE = 10 unless const_defined?(:LF_SIZE)

      # Initialize.
      def initialize(*args)
        @array = args
      end

      def empty?
        @array.empty?
      end

      def <<(value)
        @array << value
      end

      def [](key)
        @array[key]
      end

      def []=(key, value)
        @array[key] = value
      end

      def size
        @array.size
      end

      def to_s
        unless self.empty?
          # 配列が空でない場合
          if @array.size > LF_SIZE
            # 配列長がLF_SIZEを越える場合
            head = @array[0, LF_SIZE]
            tail = @array[LF_SIZE, @array.size]
            out = []
            out << "[ %s" % head.collect{|item| value_to_s(item)}.join(" ")
            indent!
            tail.each_slice(LF_SIZE){|slice|
              out << space + slice.collect{|item| value_to_s(item)}.join(" ")
            }
            outdent!
            out[out.size - 1] += " ]"
            out.join(LF)
          else
            # 配列長がLF_SIZE以下の場合
            "[ %s ]" % @array.collect{|item| value_to_s(item)}.join(" ")
          end
        else
          # 配列が空の場合
          "[ ]"
        end
      end
    end
  end
end
