# coding:utf-8

require "pdf_errors"

module RubyPdfBuilder
  module PdfHandler
    class BaseHandler
      attr_reader :lines

      def initialize(page)
        @page = page
        @stream = page.stream
      end

      # Y座標変換
      def trans_y(y)
        @page.height - y
      end
    end
  end
end
