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
        if options[:font]
          @default_font = symbol_to_font(options[:font], options)
        else
          @default_font = nil
        end
        @default_font_size = options[:font_size] || 12
        # Set default text position.
        set_xy(5, 5)
        @y -= @default_font_size
      end

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

      # Write text.
      def text(text, options = {})
        # Set font.
        font = options[:font] ?
          symbol_to_font(options[:font], options) : @default_font
        raise FontNotSpecifiedError unless font
        # Set font size.
        font_size = options[:font_size] || @default_font_size
        # Write text.
        text.split("\n").each do |token|
          if token.size > 0
            @stream << "BT"
            decoded_text = decode(font, token)
            @stream << "%s %d Tf" % [font.name, font_size]
            @stream << "%d %d Td" % [@x, @y]
            @stream << "%s Tj" % decoded_text
            @stream << "ET"
          end
          @y -= font_size
        end
        if /[\r|\n]+\z/.match(text)
          @y -= $~[0].count("\n") * font_size
        end
      end

      private
      # Get font object by symbol.
      def symbol_to_font(symbol, options = {})
        font_class = constantize_font_by_symbol(symbol)
        font_key = font_class.key(options)
        # Check for font in font list.
        unless @document.font_hash.has_key?(font_key)
          # Create font instance.
          font = font_class.new(@document, options)
          @document.font_hash[font_key] = font
        else
          # Get font instance from font hash.
          font = @document.font_hash[font_key]
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

      def decode(font, text)
        case font.encoding
        when pn!(:StandardEncoding)
          "(%s)" % text
        when pn!("UniJIS-UCS2-H")
          "<%s>" % text.toutf16.unpack("C*").collect{|c| "%02X" % c}.join("")
        else
          raise UnknownEncodingError
        end
      end
    end
  end
end
