# coding:utf-8
module Prune 
  module Elements
    class Stream < Base
      attr_reader :stream

      # Initialize.
      def initialize(document)
        super(document)
        # Set dictionary.
        @content = pd(pn(:Length) => 0)
        # Set stream.
        @stream = ps
        # Register element to document.
        register
      end

      # Convert stream to String.
      def to_s
        # Update length of the stream.
        @content[pn(:Length)] = @stream.length
        # Convert to String.
        out = []
        out << "#{@element_id} #{@revision} obj"
        out << @content.to_s
        out << @stream.to_s
        out << "endobj"
        return out.join(LF)
      end
    end
  end
end
