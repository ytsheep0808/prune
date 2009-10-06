# coding:utf-8
module Prune 
  module Elements
    class Page < Base
      attr_reader :default_font
      attr_accessor :shape_ids
      attr_accessor :shapes
      attr_accessor :x
      attr_accessor :y
      attr_accessor :current_font

      FONT_OPTIONS = [
        :name,          # Font name.
        :size,          # Font size.
        :bold,          # Bold(boolean).
        :italic,        # Italic(boolean).
        :mode,          # Font color mode.
        :fill_color,    # Color inside font.
        :stroke_color,  # Color around font.
      ] unless const_defined?(:FONT_OPTIONS)

      # Initialize.
      def initialize(document, media_box, options = {})
        super(document)
        # Set stream.
        @stream = Stream.new(@document)
        # Set dictionary.
        @content = pd(
          pn(:Type) => pn(:Page),
          pn(:Parent) => @document.pages.reference,
          pn(:MediaBox) => pa(*media_box),
          pn(:Contents) => @stream.reference,
          pn(:Resources) => pd(
            pn(:ProcSet) => @document.proc_set.reference))
        # Set default position to [5.0 mm * 5.0 mm].
        @x = 5.0
        @y = media_box[3] - 5.0
p media_box
puts "x=%.2f y=%.2f" % [@x, @y]
        # Set page default font.
        initialize_font(options)
        # Initialize page shapes.
        @shape_ids = []
        @shapes = {}
        # Register element to document.
        register
      end

      # Get stream object.
      def stream
        @stream.stream
      end

      # Get width of the page(mm).
      def width
        @content[pn(:MediaBox)][2]
      end

      # Get height of the page(mm).
      def height
        @content[pn(:MediaBox)][3]
      end

      # Set font to use.
      def set_font(key, font)
        # Add :Font key to content hash unless there is no key
        unless @content[pn(:Resources)].has_key?(pn(:Font))
          @content[pn(:Resources)].update(pn(:Font) => pd)
        end
        # Add font symbol to :Font hash
        unless @content[pn(:Resources)][pn(:Font)].has_key?(key)
          @content[pn(:Resources)][pn(:Font)].update(key => font.reference)
        end
      end

      private
      # Initialize font.
      def initialize_font(options)
        @current_font = {}
        @default_font = {
          :name => nil,
          :size => 12,
          :bold => false,
          :italic => false,
          :mode => :fill,
          :fill_color => "#000000",
          :stroke_color => "#000000"}
        # Set default and current font from options.
        if options.key?(:font)
          FONT_OPTIONS.each do |sym|
            if options[:font].key?(sym)
              @default_font[sym] = options[:font][sym]
              @current_font[sym] = @default_font[sym]
            end
          end
        end
      end
    end
  end
end
