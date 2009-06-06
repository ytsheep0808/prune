# coding:utf-8
module Prune
  module Parsers
    # Parser for directive "property".
    class PropertyParser < Base
      # Initialize.
      def initialize(document)
        @document = document
      end

      # Set title.
      def title(title)
        @document.info.title = title
      end

      # Set author.
      def author(author)
        @document.info.author = author
      end

      # Set PDF version.
      def version(version)
        valid_versions = %W[1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7]
        raise PdfVersionError unless valid_versions.include?(version)
        @document.version = version
      end
    end
  end
end
