# coding:utf-8
module Prune 
  module Elements
    class Page < Base
      # Initialize.
      def initialize(document, size)
        super(document)
        @stream = Stream.new(@document)
        media_box = size.collect{|i| mm2pt(i)}
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

      # Write a table.
      def table(widths, pos = @pos)
        raise BlockNotGivenError unless block_given?
        raise TableFormatError unless widths.is_a?(Array)
        raise TableFormatError unless widths.size > 0
        raise PositionFormatError unless pos.is_a?(Array)
        raise PositionFormatError unless pos.size == 2
        handler = TableHandler.new(self, widths.collect{|width| mm2pt(width)}, pos)
        yield handler
      end

      private
      # Draw with handler.
      def draw(&block)
        raise BlockNotGivenError unless block_given?
        handler = DrawHandler.new(self)
        stream << "q"
        yield handler
        stream << "Q"
      end

      # Draw a rectangle.
      def draw_rect(pos, width, height, line_color = [0, 0, 0], line_width = 0.5)
        orig_x = pos[0]
        orig_y = pos[1]
        dest_x = pos[0] + width
        dest_y = pos[1] + height
        draw{|handler|
          handler.set_line_cap(:projecting_square_cap)
          handler.set_line_width(line_width)
          handler.set_line_color(line_color)
          handler.move([orig_x, orig_y])
          handler.line_to([dest_x, orig_y])
          handler.line_to([dest_x, dest_y])
          handler.line_to([orig_x, dest_y])
          handler.line_to([orig_x, orig_y])
          handler.stroke
        }
      end
    end
  end
end
