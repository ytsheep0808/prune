# coding:utf-8
module Prune 
  module Elements
    class Pages < Base
      def initialize(document)
        super(document)
        @content = pd!(
          pn!(:Type) => pn!(:Pages),
          pn!(:Kids) => pa!,
          pn!(:Count) => 0)
        register
      end

      def empty?
        @content[pn!(:Kids)].empty?
      end

      def <<(page)
        @content[pn!(:Kids)] << page.reference
        @content[pn!(:Count)] += 1
      end
    end
  end
end