# coding:utf-8
module Prune 
  module Fonts
    class Base
      include Errors
      include PObjects
      include Elements

      class << self
        # Check font flags.
        def flags(options)
          raise FontOptionError unless
            [true, false, nil].include?(options[:bold])
          raise FontOptionError unless
            [true, false, nil].include?(options[:italic])
          bold = options[:bold] || false
          italic = options[:italic] || false
          return [bold, italic]
        end
      end

      # Initialize.
      def initialize(document)
        @document = document
        @font_elements = []
        @main_element = nil
      end

      # Get reference of the font.
      def reference
        @main_element.reference
      end

      # Get name of the font.
      def name
        @main_element.name
      end

      # Get encoding of the font.
      def encoding
        @main_element.encoding
      end

      private
      # Check font flags.
      def flags(options)
        self.class.flags(options)
      end
    end
  end
end
