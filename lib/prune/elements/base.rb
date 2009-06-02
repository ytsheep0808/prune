# coding:utf-8

module Prune
  module Elements
    class Base
      def initialize(pdf)
        @pdf = pdf
        @element_id = 0
        @revision = 0
        @content = nil
        @stream = nil
        @registered = false
      end

      def to_s
        raise ObjectNotRegisteredError if @element_id <= 0
        out = []
        out << "%d %d obj" % [@element_id, @revision]
        out << @content.to_s
        out << "endobj"
        return out.join(LF)
      end

      def reference_id
        "%d %d R" % [@element_id, @revision]
      end

      def reference
        "#{@element_id} #{@revision} R"
      end

      def register
        unless @registered
          @element_id = @pdf.object_list.size + 1
          @pdf.object_list << self
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
