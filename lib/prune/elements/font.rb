# coding:utf-8

module Prune 
  module Elements
    class Font < Base
      include Prune

      attr_reader :name
      attr_reader :content

      def initialize(hash)
        super(nil)
        @name = hash[:Name]
        @content = pd!(pn!(:Type) => pn!(:Font))
        @content.update(hash)
      end

      def encoding
        @content[:Encoding]
      end
    end
  end
end
