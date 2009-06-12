# coding:utf-8
module Prune 
  module Elements
    class Outlines < Base
      def initialize(document)
        super(document)
        @content = pd(
          pn(:Type) => pn(:Outlines),
          pn(:Count) => 0)
        register
      end
    end
  end
end
