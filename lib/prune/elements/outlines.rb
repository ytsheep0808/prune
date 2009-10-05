# coding:utf-8
module Prune 
  module Elements
    class Outlines < Base
      # Initialize.
      def initialize(document)
        super(document)
        # Set dictionary.
        @content = pd(
          pn(:Type) => pn(:Outlines),
          pn(:Count) => 0)
        # Register element to document.
        register
      end
    end
  end
end
