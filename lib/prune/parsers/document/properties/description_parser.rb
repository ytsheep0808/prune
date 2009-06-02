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
        valid_versions = %W[1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7]
        raise PdfVersionError unless valid_versions.include?(version)
        @document.version = version
      end
    end
  end
end
