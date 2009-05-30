# coding:utf-8

require "pdf_object/base_object"

module RubyPdfBuilder
  module PdfObject
    class Stream < BaseObject
      attr_reader :stream

      def initialize(pdf)
        super(pdf)
        @content = PdfDictionary.new({:Length => 0})
        @stream = PdfStream.new()
        register
      end

      def to_s
        raise ObjectNotRegisteredError if @obj_id <= 0
        # ストリーム長の更新
        @content[:Length] = @stream.length
        # 文字列の出力
        out = []
        out << "%d %d obj" % [@obj_id, @revision]
        out << @content.to_s
        out << @stream.to_s
        out << "endobj"
        return out.join(LF)
      end
    end
  end
end
