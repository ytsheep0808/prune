# coding:utf-8
module Prune
  module Parsers
    # Parser for directive "page".
    class PageParser < Base
      # Initialize.
      def initialize(document, size, options = {})
        @document = document
        # Check document size.
        raise DocumenteSizeError unless DOCUMENT_SIZE.has_key?(size)
        # Create a new page.
        @page = Page.new(@document, DOCUMENT_SIZE[size])
        @stream = @page.stream

        # Add page to pages.
        @document.pages << @page

        # Initialize page variables
        @default_font_sym = @font_sym =
          options[:font] || nil
        @default_font_bold = @font_bold =
          options[:bold] || false
        @default_font_italic = @font_italic =
          options[:italic] || false
        @default_font_size = @font_size =
          options[:font_size] || 12
        @default_font_mode = @font_mode =
          options[:font_mode] || :fill
        @default_fill_color = @fill_color =
          options[:fill_color] || "#000000"
        @default_stroke_color = @stroke_color =
          options[:stroke_color] || "#000000"

        # Set default text position.
        set_xy(5, 5)
      end

      protected
      # Set X position by millimeter.
      def set_x(x)
        raise PositionError unless x.kind_of?(Numeric)
        @x = mm2pt(x)
      end

      # Set Y position by millimeter.
      def set_y(y)
        raise PositionError unless y.kind_of?(Numeric)
        @y = @page.height - mm2pt(y)
      end

      # Set X and Y positions by millimeter.
      def set_xy(x, y)
        set_x(x)
        set_y(y)
      end

      # Set default font.
      def set_default_font(symbol, options)
        @default_font = symbol_to_font(symbol, options)
        @default_font_size = options[:font_size] if options[:font_size]
      end

      # Div tag.
      def div(string, options = {})
        orig_x = @x
        orig_y = @y
        width, height = text(string, options)
        @x = orig_x
        @y = orig_y - height
      end

      # Span tag.
      def span(string, options = {})
        orig_x = @x
        orig_y = @y
        width, height = text(string, options)
        @x = orig_x + width
        @y = orig_y
      end

      # Br tag.
      def br
        @x = mm2pt(5)
        @y -= @font_size
      end

      private
      # Write text.
      def text(string, options)
        # Save original position.
        orig_x = @x
        orig_y = @y
        # Define local variable for current x and y.
        current_x = @x
        current_y = @y
        # Erase \r\n linefeeds and \r line feeds.
        string.gsub!(/\r\n/, "\n")
        string.gsub!(/\r/, "\n")
        string += "\n" unless /\n\z/ === string
        # Set font.
        @font_sym = options[:font] || @default_font_sym
        @font_bold = options[:bold].nil? ?
          @default_font_bold : options[:bold]
        @font_italic = options[:italic].nil? ?
          @default_font_italic : options[:italic]
        @font = symbol_to_font(@font_sym,
          :bold => @font_bold, :italic => @font_italic)
        raise FontNotSpecifiedError unless @font
        # Set font size.
        @font_size = options[:font_size] || @default_font_size
        # Set stroke color.
        @stroke_color = options[:stroke_color] || @default_stroke_color
        # Set fill color.
        @fill_color = options[:fill_color] || @default_fill_color
        # Set font mode.
        @font_mode = options[:font_mode] || @default_font_mode
        # Get width and height of the text.
        width, height = width_and_height(string, @font, @font_size)
        # Fill background.
        @stream << "q"
        @stream << "%s RG" % convert_color("#FF0000")
        @stream << "#{orig_x} #{orig_y} #{width} #{-height} re"
        @stream << "s"
        # Write text.
        current_y -= @font_size
        string.scan(/([^\n]*)\n/) do |token|
          if token[0].size > 0
            @stream << "%s RG" % convert_color(@stroke_color)
            @stream << "%s rg" % convert_color(@fill_color)
            @stream << "BT"
            @stream << "%s %d Tf" % [@font.name, @font_size]
            @stream << "%d %d Td" % [current_x, current_y]
            @stream << "%d Tr" % convert_font_mode(@font_mode)
            @stream << "%s Tj" % @font.decode(token[0])
            @stream << "ET"
          end
          current_y -= @font_size
        end
        @stream << "Q"
        [width, height]
      end

      # Get font object by symbol.
      def symbol_to_font(symbol, options = {})
        font_class = constantize_font_by_symbol(symbol)
        font_key = font_class.key(options)
        # Check for font in font list.
        unless @document.fonts.has_key?(font_key)
          # Create font instance.
          font = font_class.new(@document, options)
          @document.fonts[font_key] = font
        else
          # Get font instance from font hash.
          font = @document.fonts[font_key]
        end
        @page.set_font(font_key, font)
        font
      end

      # Constantize font by font symbol.
      def constantize_font_by_symbol(symbol)
        raise UnexistingFontError unless symbol.instance_of?(Symbol)
        font_name = symbol.to_s
        # This symbol consists of only alphabets and underscores.
        raise UnexistingFontError unless /\A[a-z][a-z_]*[a-z]\z/ === font_name
        # This symbol should contain only one underscore at a time.
        raise UnexistingFontError if /_{2,}/ === font_name
        # Convert underscored string to camel-case string.
        font_name.gsub!(/(?:^|_)(.)/){$1.upcase}
        begin
          eval("Fonts::#{font_name}")
        rescue
          raise UnexistingFontError
        end
      end

      def convert_color(color_str)
        raise ColorError unless color_str.instance_of?(String)
        raise ColorError unless /\A#[0-9a-fA-F]{6}\z/ === color_str
        r = color_str[1,2].to_i(16) / 255.0
        g = color_str[3,2].to_i(16) / 255.0
        b = color_str[5,2].to_i(16) / 255.0
        "%.2f %.2f %.2f" % [r, g, b]
      end

      def convert_font_mode(mode)
        case mode
        when :fill
          0
        when :stroke
          1
        when :fill_and_stroke
          2
        else
          raise FontModeError
        end
      end

      # Get width and height of the text.
      def width_and_height(string, font, font_size)
        width = 0
        height = 0
        string.scan(/([^\n]*)\n/) do |token|
          height += font_size
          token_width = font.width(token[0], font_size)
          if token_width > width
            width = token_width
          end
        end
        width += font_size / 10
        height += font_size / 5
        [width, height]
      end
    end
  end
end
