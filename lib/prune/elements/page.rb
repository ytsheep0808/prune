# coding:utf-8
require "pdf_handlers"
require "pdf_fonts"

module Prune 
  module Elements
    class Page < Base
      include Prune
      include PdfHandler
      include PdfFont

      attr_reader :font, :font_size

      def initialize(pdf, size)
        super(pdf)
        @stream = Stream.new(@pdf)
        media_box = size.collect{|i| mm2pt(i)}
        @content = pd!(
          pn!(:Type) => pn!(:Page),
          pn!(:Parent) => @pdf.pages.reference,
          pn!(:MediaBox) => pa!(*media_box),
          pn!(:Contents) => @stream.reference,
          pn!(:Resources) => pd!(
            pn!(:ProcSet) => @pdf.proc_set.reference))
        @font = nil
        @font_size = 12
        @pos = [mm2pt(5), mm2pt(5)]
        register
      end

      # Get stream object.
      def stream
        @stream.stream
      end

      # Get height of the document.
      def height
        @content[:MediaBox][3]
      end

      # Set font to use.
      def set_font(font_sym, font_size = @font_size)
        # Check for font in font list
        unless @pdf.font_hash.has_key?(font_sym)
          # Create font instance
          font = eval(font_sym_to_class_name(font_sym)).new(@pdf)
          @pdf.font_hash[font_sym] = font
        else
          # Get font instance from font hash
          font = @pdf.font_hash[font_sym]
        end
        # Add :Font key to content hash unless there is no key
        unless @content[:Resources].has_key?(:Font)
          @content[:Resources].update(:Font => PdfDictionary.new)
        end
        # Add font symbol to :Font hash
        unless @content[:Resources][:Font].has_key?(font_sym)
          @content[:Resources][:Font].update(font_sym => font)
        end
        # Update text font and size
        @font = font
        @font_size = font_size
      end

      # Set writing position.
      def set_pos(x, y)
        @pos = [mm2pt(x), mm2pt(y)]
      end

      # Write text without line feed at the end of the line.
      def write(text, pos = nil)
        raise FontNotSpecifiedError unless @font
        raise FontNotSpecifiedError unless @font_size
        # Update position if given
        if pos.is_a?(Array) && pos.size == 2
          @pos = pos.collect{|xy| mm2pt(xy)}
        end
        # Initialize handler
        handler = TextHandler.new(self)
        handler.write(text, @font, @font_size, @pos)
      end

      # Write text with line feed at the end of the line.
      def puts(text, pos = nil)
        write(text, pos)
        # Set position to next row
        @pos[1] += @font_size * (text.count("\n") + 1)
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
