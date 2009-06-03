# coding:utf-8

module Prune
  module Parsers
    # parser for directive "page"
    class PageParser
      # initialize
      def initialize(document, size)
        @document = document
        # Check document size
        raise DocumenteSizeError unless DOCUMENT_SIZE.has_key?(size)
        # Create a new page
        @page = Elements::Page.new(@document, DOCUMENT_SIZE[size])
        # Add page to pages
        @document.pages << @page
      end
    end
  end
end
