# coding:utf-8

require "pdf_object/base_object"

module Prune 
  module PdfObject
    class ProcedureSets < BaseObject
      def initialize(pdf)
        super(pdf)
        @content = PdfArray.new([:PDF, :Text, :ImageB, :ImageC, :ImageI])
        register
      end
    end
  end
end
