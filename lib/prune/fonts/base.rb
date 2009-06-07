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

        # Get font name.
        def font_name
          class_name = self.to_s.gsub(/\A.*::/, "")
          class_name.gsub(/\A(.)/){$1.downcase}.gsub(/([A-Z])/){"_#{$1.downcase}"}
        end
      end

      attr_reader :font_name

      # Initialize.
      def initialize(document)
        @document = document
        @main_element = nil
        @font_name = self.class.font_name
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

      # Get font symbol.
      def font_sym
        @font_name.to_sym
      end

      private
      # Check bold flags.
      def bold?(options)
        self.class.bold?(options)
      end

      # Check italic flags.
      def italic?(options)
        self.class.italic?(options)
      end

      # Calculate flags.
      def calculate_flags(options = {})
        raise FontDescriptorFlagError unless options.values.all?{|value|
          [true, false].include?(value)
        }
        flags = 0b00000000000000000000000000000000
        flags |= 0b00000000000000000000000000000001 if options[:fixed_pitch]
        flags |= 0b00000000000000000000000000000010 if options[:serif]
        flags |= 0b00000000000000000000000000000100 if options[:symbolic]
        flags |= 0b00000000000000000000000000001000 if options[:script]
        flags |= 0b00000000000000000000000000100000 if options[:non_symbolic]
        flags |= 0b00000000000000000000000001000000 if options[:italic]
        flags |= 0b00000000000000010000000000000000 if options[:all_cap]
        flags |= 0b00000000000000100000000000000000 if options[:small_cap]
        flags |= 0b00000000000001000000000000000000 if options[:force_bold]
        flags
      end
    end
  end
end
