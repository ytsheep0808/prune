# coding:utf-8
module Prune
  module Parsers
    # Parser for directive "page".
    class PageParser < Base
      attr_reader :page

      # Initialize.
      def initialize(document, size, options = {})
        @document = document
        # Check document size.
        raise DocumenteSizeError unless DOCUMENT_SIZES.has_key?(size)
        document_size = DOCUMENT_SIZES[size]
        # Create a new page.
        width, height = document_size.collect{|mm| mm2pt(mm)}
        @page = Page.new(@document, [0.0, 0.0, width, height], options)
        # Add page to pages.
        @document.pages << @page
      end

      protected
      def rect(x, y, width, height, options = {})
        rect = Shapes::Rectangle.new(@page, [x, y, width, height], options)
        rect.render
        rect
      end

      # Div tag.
      def div(string, options = {})
        options[:width] = @page.width - 10.0
        #boundary = text(string, options)
        #@y = boundary[1] - boundary[3]
        div = Shapes::TextBox.new(@page, string, options)
        div.render
#        pos = div.pos(:left_bottom)
#        @page.position.update(pos.x, pos.y)
        lf
        div
      end

      # Span tag.
      def span(string, options = {})
        #boundary = text(string, options)
        #@x = boundary[0] + boundary[2]
        span = Shapes::TextBox.new(@page, string, options)
        span.render
        @page.x += span.width
        #@page.position += Position[span.x, 0.0]
        span
      end

      # Br tag.
      def br
        lf
      end

      # Line feed.
      def lf(feed = 1)
        feed = 1 unless feed < 0
        @page.x = 5.0
        font_size = @page.current_font[:size]
        feed.times do
          @page.y -= font_size + (font_size / 5)
        end
      end
    end
  end
end
