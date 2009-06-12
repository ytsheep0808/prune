# coding:utf-8
module Prune 
  module Elements
    class ProcedureSets < Base
      def initialize(document)
        super(document)
        @content = pa(
          pn(:PDF),
          pn(:Text),
          pn(:ImageB),
          pn(:ImageC),
          pn(:ImageI))
        register
      end
    end
  end
end
