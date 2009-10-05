# coding:utf-8
module Prune 
  module Elements
    class ProcedureSets < Base
      # Initialize.
      def initialize(document)
        super(document)
        # Set dictionary.
        @content = pa(
          pn(:PDF),
          pn(:Text),
          pn(:ImageB),
          pn(:ImageC),
          pn(:ImageI))
        # Register element to document.
        register
      end
    end
  end
end
