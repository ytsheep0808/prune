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
        puts self.class.to_s + ".title=" + title
        @document.info.title = title
      end

      # set author
      def author(author)
        puts self.class.to_s + ".author=" + author
        @document.info.author = author
      end
    end
  end
end
