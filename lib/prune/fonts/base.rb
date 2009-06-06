# coding:utf-8
module Prune 
  module Fonts
    class Base
      include Errors
      include PObjects
      include Elements

      class << self
        # Check bold flag.
        def bold?(options)
          raise FontOptionError unless
            [true, false, nil].include?(options[:bold])
          options[:bold] || false
        end

        # Check italic flag.
        def italic?(options)
          raise FontOptionError unless
            [true, false, nil].include?(options[:italic])
          options[:italic] || false
        end
      end

      # Initialize.
      def initialize(document)
        @document = document
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
      # Check bold flags
      def bold?(options)
        self.class.bold?(options)
      end

      # Check italic flags
      def italic?(options)
        self.class.italic?(options)
      end
    end
  end
end
