# coding:utf-8

module Prune 
  module Elements
    class ProcedureSets < Base
      def initialize(pdf)
        super(pdf)
        @content = pa!(
          pn!(:PDF),
          pn!(:Text),
          pn!(:ImageB),
          pn!(:ImageC),
          pn!(:ImageI))
        register
      end
    end
  end
end
