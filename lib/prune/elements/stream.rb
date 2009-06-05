# coding:utf-8

module Prune 
  module Elements
    class Stream < Base
      include Prune
      attr_reader :stream

      def initialize(document)
        super(document)
        @content = pd!(pn!(:Length) => 0)
        @stream = ps!
        register
      end

      def to_s
        # ストリーム長の更新
        @content[pn!(:Length)] = @stream.length
        # 文字列の出力
        out = []
        out << "%d %d obj" % [@element_id, @revision]
        out << @content.to_s
        out << @stream.to_s
        out << "endobj"
        return out.join(LF)
      end
    end
  end
end
