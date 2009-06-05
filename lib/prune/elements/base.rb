# coding:utf-8

module Prune
  module Elements
    class Base
      include PObjects

      def initialize(document)
        @document = document
        @element_id = 0
        @revision = 0
        @content = nil
        @stream = nil
        @registered = false
      end

      def to_s
        raise ObjectNotRegisteredError unless @registered
        out = []
        out << "%d %d obj" % [@element_id, @revision]
        out << @content.to_s
        out << "endobj"
        return out.join(LF)
      end

      def element_id
        raise ObjectNotRegisteredError unless @registered
        @element_id
      end

      def reference
        raise ObjectNotRegisteredError unless @registered
        "#{@element_id} #{@revision} R"
      end

      def register
        unless @registered
          @element_id = @document.object_list.size + 1
          @document.object_list << self
          @registered = true
        end
      end

      private
      def inspect
        self.to_s
      end
    end
  end
end
