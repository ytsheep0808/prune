# coding:utf-8

module Prune 
  module Elements
    class Pages < Base
      include Prune

      def initialize(pdf)
        super(pdf)
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
        raise MalFormedPageError unless page.instance_of?(Page)
        @content[pn!(:Kids)] << page.reference
        @content[pn!(:Count)] += 1
      end
    end
  end
end
