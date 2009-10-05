# coding:utf-8
module Prune 
  module Elements
    class Page < Base
      # Initialize.
      def initialize(document, media_box)
        super(document)
        @stream = Stream.new(@document)
        @content = pd(
          pn(:Type) => pn(:Page),
          pn(:Parent) => @document.pages.reference,
          pn(:MediaBox) => pa(*media_box),
          pn(:Contents) => @stream.reference,
          pn(:Resources) => pd(
            pn(:ProcSet) => @document.proc_set.reference))
        register
      end

      # Get stream object.
      def stream
        @stream.stream
      end

      # Get width of the page.
      def width
        @content[pn(:MediaBox)][2]
      end

      # Get height of the page.
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
    end
  end
end
