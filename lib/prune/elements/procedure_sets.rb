# coding:utf-8

require "elements/base"

module Prune 
  module Elements
    class ProcedureSets < Base
      def initialize(pdf)
        super(pdf)
        @content = PdfArray.new([:PDF, :Text, :ImageB, :ImageC, :ImageI])
        register
      end
    end
  end
end
