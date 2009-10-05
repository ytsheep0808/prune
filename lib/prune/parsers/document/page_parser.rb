# coding:utf-8
module Prune
  module Parsers
    # Parser for directive "page".
    class PageParser < Base
      FONT_OPTIONS = [
        :name, :bold, :italic, :size, :mode,
        :fill_color, :stroke_color
      ] unless const_defined?(:FONT_OPTIONS)

      # Initialize.
      def initialize(document, size, options = {})
        @document = document
        # Check document size.
        raise DocumenteSizeError unless DOCUMENT_SIZES.has_key?(size)
        document_size = DOCUMENT_SIZES[size]
        # Create a new page.
        width, height = document_size
        @page = Page.new(@document, [0.0, 0.0, width, height])
        @stream = @page.stream

        # Add page to pages.
        @document.pages << @page

        # Current variables will be set to this hash.
        @variables = {}
        # Default variables will be set to this hash.
        @defaults = {}
        # Initialize font variables
        @variables[:font] = {}
        @defaults[:font] = {}
        @defaults[:font][:name] = nil
        @defaults[:font][:bold] = false
        @defaults[:font][:italic] = false
        @defaults[:font][:size] = 12
        @defaults[:font][:mode] = :fill
        @defaults[:font][:fill_color] = "#000000"
        @defaults[:font][:stroke_color] = "#000000"
        if options[:font]
          FONT_OPTIONS.each do |sym|
            unless options[:font][sym].nil?
              @defaults[:font][sym] = options[:font][sym]
            end
            @variables[:font][sym] = @defaults[:font][sym]
          end
        end
        # Set default XY position.
        self.x = 5
        self.y = 5
      end

      protected
      # Get X position by millimeter.
      def x
        pt2mm(@x)
      end

      # Set X position by millimeter.
      def x=(x)
        raise PositionError unless x.kind_of?(Numeric)
        @x = mm2pt(x)
      end

      # Get Y position by millimeter.
      def y
        pt2mm(@y)
      end

      # Set Y position by millimeter.
      def y=(y)
        raise PositionError unless y.kind_of?(Numeric)
        @y = @page.height - mm2pt(y)
      end

      # Div tag.
      def div(string, options = {})
        options[:width] = @page.width - mm2pt(10)
        boundary = text(string, options)
        @y = boundary[1] - boundary[3]
      end

      # Span tag.
      def span(string, options = {})
        boundary = text(string, options)
        @x = boundary[0] + boundary[2]
      end

      # Br tag.
      def br
        self.x = 5
        font_size = @variables[:font][:size]
        @y -= font_size + (font_size / 5)
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
        # Parse font options
        FONT_OPTIONS.each do |sym|
          if options[:font] && !options[:font][sym].nil?
            @variables[:font][sym] = options[:font][sym]
          else
            @variables[:font][sym] = @defaults[:font][sym]
          end
        end
        font = symbol_to_font(@variables[:font][:name],
          :bold => @variables[:font][:bold],
          :italic => @variables[:font][:italic])
        raise FontNotSpecifiedError unless font
        # Save font size to local variable.
        font_size = @variables[:font][:size]
        # Text align.
        @variables[:text_align] = options[:text_align] || :left
        # Get width and height of the text.
        width, height = width_and_height(string, font, font_size)
        width = options[:width] if options[:width]
        height = options[:height] if options[:height]
        boundary = [orig_x, orig_y, width, height]
        # Start stream.
        @stream << "q"
        # Fill background.
        fill_background(boundary, options)
        # Draw borders.
        draw_rect_border(boundary, options)
        draw_top_border(boundary, options)
        draw_left_border(boundary, options)
        draw_right_border(boundary, options)
        draw_bottom_border(boundary, options)
        # Write text.
        current_y -= font_size
        string.scan(/([^\n]*)\n/) do |token|
          line = token[0]
          if line.size > 0
            line_width = font.width(line, font_size)
            @stream << "%s RG" % convert_color(
              @variables[:font][:stroke_color])
            @stream << "%s rg" % convert_color(
              @variables[:font][:fill_color])
            @stream << "BT"
            @stream << "%s %d Tf" % [font.name, font_size]
            position = [current_x, current_y]
            position[0] = convert_text_align(
              line_width, width, current_x, @variables[:text_align])
            @stream << "%.2f %.2f Td" % position
            @stream << "%d Tr" % convert_font_mode(
              @variables[:font][:mode])
            @stream << "%s Tj" % font.decode(line)
            @stream << "ET"
          end
          current_y -= font_size
        end
        @stream << "Q"
        boundary
      end

      # Fill background.
      def fill_background(boundary, options)
        color = options[:background_color]
        return unless color
        @stream << "%s rg" % convert_color(color)
        @stream << "%.2f %.2f %.2f %.2f re" % 
          [boundary[0], boundary[1], boundary[2], -boundary[3]]
        @stream << "f"
      end

      # Draw rectangular border.
      def draw_rect_border(boundary, options)
        return unless options[:border]
        return if options[:border_top]
        return if options[:border_left]
        return if options[:border_right]
        return if options[:border_bottom]
        style = options[:border][:style] || :none
        width = options[:border][:width] || 1.0
        color = options[:border][:color] || "#000000"
        return if style == :none
        case style
        when :solid
          @stream << "[] 0 d"
        when :dashed
          @stream << "[4 5] 0 d"
        else
          raise BorderOptionError
        end
        @stream << "2 J"
        @stream << "0 j"
        @stream << "%s RG" % convert_color(color)
        @stream << "%.2f w" % width
        @stream << "%.2f %.2f %.2f %.2f re" %
          [boundary[0], boundary[1], boundary[2], -boundary[3]]
        @stream << "s"
      end

      # Draw top border.
      def draw_top_border(boundary, options)
        return unless options[:border_top]
        from = [boundary[0], boundary[1]]
        to = [boundary[0] + boundary[2], boundary[1]]
        draw_single_border(from, to, options[:border_top])
      end

      # Draw left border.
      def draw_left_border(boundary, options)
        return unless options[:border_left]
        from = [boundary[0], boundary[1]]
        to = [boundary[0], boundary[1] - boundary[3]]
        draw_single_border(from, to, options[:border_left])
      end

      # Draw right border.
      def draw_right_border(boundary, options)
        return unless options[:border_right]
        from = [boundary[0] + boundary[2], boundary[1]]
        to = [boundary[0] + boundary[2], boundary[1] - boundary[3]]
        draw_single_border(from, to, options[:border_right])
      end

      # Draw bottom border.
      def draw_bottom_border(boundary, options)
        return unless options[:border_bottom]
        from = [boundary[0], boundary[1] - boundary[3]]
        to = [boundary[0] + boundary[2], boundary[1] - boundary[3]]
        draw_single_border(from, to, options[:border_bottom])
      end

      # Draw single border.
      def draw_single_border(from, to, options)
        style = options[:style] || :none
        width = options[:width] || 1.0
        color = options[:color] || "#000000"
        return if style == :none
        case style
        when :solid
          @stream << "[] 0 d"
        when :dashed
          @stream << "[5 5] 0 d"
        else
          raise BorderOptionError
        end
        @stream << "2 J"
        @stream << "0 j"
        @stream << "%s RG" % convert_color(color)
        @stream << "%.2f w" % width
        @stream << "%.2f %.2f m" % from
        @stream << "%.2f %.2f l" % to
        @stream << "s"
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

      # Text align.
      def convert_text_align(string_width, width, x, text_align)
        # Do nothing when left alignment is given.
        return x if text_align == :left
        # Do nothing when no width is given.
        return x unless width
        # Do nothing when string width is smaller than width.
        return x if width <= string_width
        # Calculate x positions.
        case text_align
        when :center
          (width - string_width) / 2.0
        when :right
          width - string_width
        else
          raise TextAlignError
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
