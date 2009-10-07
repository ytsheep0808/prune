# coding:utf-8
module Prune
  module Shapes
    class TextBox < Base
      attr_accessor :width
      attr_accessor :height

      # Initialize.
      def initialize(page, string, options = {})
        super(page)
        # Set instance variables.
        @id = options[:id] if options.key?(:id)
        @x = @page.x
        @y = @page.y
        @options = options
        # Erase "\r\n" and "\r" line feeds.
        @string = string.gsub(/\r\n/, "\n").gsub(/\r/, "\n")
        @string << "\n" unless /\n\z/ === @string
        # Parse font options.
        Elements::Page::FONT_OPTIONS.each do |sym|
          @page.current_font[sym] = @page.default_font[sym]
          if options.key?(:font) && options[:font].key?(sym)
            @page.current_font[sym] = options[:font][sym]
          end
        end
        # Get font.
        @font = get_font(@page.current_font[:name],
          :bold => @page.current_font[:bold],
          :italic => @page.current_font[:italic])
        raise FontNotSpecifiedError if @font.nil?
        @font_size = @page.current_font[:size]
        # Text align.
        @text_align = options[:text_align] || :left
        @width = get_width(@string, @font, @font_size, options[:width])
        @height = get_height(@string, @font, @font_size, options[:height])
      end

      # Render shape.
      def render
        # Define local variables.
        current_x = @x
        current_y = @y
        boundary = [@x, @y, @width, @height]
        # Render background color.
        render_background_color(boundary)
        # Render borders.
        render_rectangle_border(boundary)
        render_top_border(boundary)
        render_left_border(boundary)
        render_right_border(boundary)
        render_bottom_border(boundary)
        # Render String.
        stream = []
        current_y -= @font_size
        stream << "q"
        # Set colors.
        stroke_color = @page.current_font[:stroke_color]
        fill_color = @page.current_font[:fill_color]
        mode = font_mode(@page.current_font[:mode])
        stream << "%s RG" % convert_color_str(stroke_color)
        stream << "%s rg" % convert_color_str(fill_color)
        # Write String.
        @string.scan(/([^\n]*)\n/) do |token|
          line = $1
          line_width = @font.width(line, @font_size)
          current_x =
            x_of_text_align(line_width, @width, current_x, @text_align)
          # Set to stream.
          if line.size > 0
            stream << "BT"
            stream << "%s %d Tf" % [@font.name, @font_size]
            stream << "%.2f %.2f Td" % [current_x, current_y]
            stream << "%d Tr" % mode
            stream << "%s Tj" % @font.decode(line)
            stream << "ET"
          end
          current_y -= @font_size
        end
        stream << "Q"
        super(stream)
      end

      private
      # Get font from options.
      def get_font(name, options)
        raise UnexistingFontError if name.nil?
        font_name = name.to_s
        # Font name shold contain only lower case alphabets and underscores.
        raise UnexistingFontError unless
          /\A[a-z][a-z_]*[a-z]\z/ === font_name
        # Font name should contain one underscore at a time.
        raise UnexistingFontError if /_{2,}/ === font_name
        # Constantize font.
        font_class_name = font_name.gsub(/(?:^|_)(.)/){$1.upcase}
        font_class = eval("Fonts::#{font_class_name}") rescue UnexistingFontError
        # Find font instance in document.
        font_key = font_class.key(options)
        if @document.fonts.key?(font_key)
          font = @document.fonts[font_key]
        else
          font = font_class.new(@document, options)
          @document.fonts.update(font_key => font)
        end
        # Set font in page instance.
        @page.set_font(font_key, font)
        font
      end

      # Render background color.
      def render_background_color(boundary)
        color = @options[:background_color]
        return unless color
        x, y, width, height = boundary
        fill_rect = Rectangle.new(@page, x, y, width, height,
          :fill => true, :fill_color => color)
        fill_rect.render
      end

      # Render rectangle border.
      def render_rectangle_border(boundary)
        return unless @options[:border]
        return if @options[:border_top]
        return if @options[:border_right]
        return if @options[:border_left]
        return if @options[:border_bottom]
        x, y, width, height = boundary
        border_rect = Rectangle.new(@page, x, y, width, height,
          @options[:border])
        border_rect.render
      end

      # Render top border.
      def render_top_border(boundary)
        return unless @options[:border_top]
        x, y, width, height = boundary
        line = Line.new(@page, x, y, x + width, y,
          @options[:border_top])
        line.render
      end

      # Render left border.
      def render_left_border(boundary)
        return unless @options[:border_left]
        x, y, width, height = boundary
        line = Line.new(@page, x, y, x, y - height,
          @options[:border_left])
        line.render
      end

      # Render right border.
      def render_right_border(boundary)
        return unless @options[:border_right]
        x, y, width, height = boundary
        line = Line.new(@page, x + width, y, x + width, y - height,
          @options[:border_right])
        line.render
      end

      # Render bottom border.
      def render_bottom_border(boundary)
        return unless @options[:border_bottom]
        x, y, width, height = boundary
        line = Line.new(@page, x, y - height, x + width, y - height,
          @options[:border_bottom])
        line.render
      end

      # Get width.
      def get_width(string, font, font_size, default_width)
        return default_width unless default_width.nil?
        width = 0.0
        string.scan(/([^\n]*)\n/) do |token|
          token_width = font.width(token[0], font_size)
          width = token_width if token_width > width
        end
        width += font_size / 10.0
      end

      # Get height.
      def get_height(string, font, font_size, default_height)
        return default_height unless default_height.nil?
        height = string.count("\n") * font_size
        height += font_size / 5.0
      end

      # Get font mode.
      def font_mode(mode)
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

      # Get text align.
      def x_of_text_align(string_width, width, x, text_align)
        return x if text_align == :left
        return x unless width
        return x if width <= string_width
        # Calculate x position.
        case text_align
        when :center
          (width - string_width) / 2.0
        when :right
          width - string_width
        else
          raise TextAlignError
        end
      end
    end
  end
end
