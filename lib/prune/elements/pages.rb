# coding:utf-8
module Prune 
  module Elements
    class Pages < Base
      # Initialize.
      def initialize(document)
        super(document)
        @content = pd(
          pn(:Type) => pn(:Pages),
          pn(:Kids) => pa,
          pn(:Count) => 0)
        register
      end

      # Determine emptyness of pages.
      def empty?
        @content[pn(:Kids)].empty?
      end

      # Add page.
      def <<(page)
        @content[pn(:Kids)] << page.reference
        @content[pn(:Count)] += 1
      end
    end
  end
end
