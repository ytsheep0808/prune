# coding:utf-8

require "pdf_type/pdf_base_type"

module Prune
  module PObjects
    class PArray < PObject
      SLICE = 10

      def initialize(array = [])
        @array = array
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
          if @array.size > SLICE
            # 配列長がSLICEを越える場合
            head = @array[0, SLICE]
            tail = @array[SLICE, @array.size]
            out = []
            out << "[ %s" % head.collect{|item| value_to_s(item)}.join(" ")
            indent!
            tail.each_slice(SLICE){|slice|
              out << space + slice.collect{|item| value_to_s(item)}.join(" ")
            }
            outdent!
            out[out.size - 1] += " ]"
            out.join(LF)
          else
            # 配列長がSLICE以下の場合
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
