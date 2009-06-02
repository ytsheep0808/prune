# coding:utf-8

module Prune
  module Parsers
    # parser for directive "description"
    class DescriptionParser
      # initialize
      def initialize(document)
        @document = document
      end

      # set title
      def title(title)
        @document.info.title = title
      end

      # set author
      def author(author)
        @document.info.author = author
      end

      # set pdf version
      def version(version)
        raise PdfVersionError unless
          /\A\d\.\d\z/ === version
        @document.version = version
      end
    end
  end
end
