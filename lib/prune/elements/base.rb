# coding:utf-8
module Prune
  module Elements
    class Base
      include Errors
      include PObjects
      include Functions

      def initialize(document)
        @document = document
        @element_id = 0
        @revision = 0
        @content = nil
        @stream = nil
        @registered = false
      end

      def to_s
        raise ElementNotRegisteredError unless @registered
        out = []
        out << "%d %d obj" % [@element_id, @revision]
        out << @content.to_s
        out << "endobj"
        return out.join(LF)
      end

      def reference
        raise ObjectNotRegisteredError unless @registered
        "#{@element_id} #{@revision} R"
      end

      def register
        unless @registered
          @element_id = @document.elements.size + 1
          @document.elements << self
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
