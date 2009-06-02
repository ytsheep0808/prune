# coding:utf-8

module Prune 
  module Elements
    class Outlines < Base
      include Prune

      def initialize(pdf)
        super(pdf)
        @content = pd!(
          pn!(:Type) => pn!(:Outlines),
          pn!(:Count) => 0)
        register
      end
    end
  end
end
