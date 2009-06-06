# coding:utf-8
module Prune
  module Parsers
    # Parser for directive "page".
    class PageParser < Base
      # Initialize.
      def initialize(document, size)
        @document = document
        # Check document size.
        raise DocumenteSizeError unless DOCUMENT_SIZE.has_key?(size)
        # Create a new page.
        @page = Page.new(@document, DOCUMENT_SIZE[size])
        @stream = @page.stream
        # Add page to pages.
        @document.pages << @page
        # Initialize page variables
        @font = nil
        @font_size = 12
        @font_color = "#000000"
        @pos = [mm2pt(5), mm2pt(5)]
      end

      # Set position.
      def set_pos(x, y)
        @pos = [mm2pt(x), mm2pt(y)]
      end

      # Set font.
      def font(symbol, options = {})
        @font_size = options[:size] if options[:size]
        @font_color = options[:color] if options[:color]
        font_class = constantize_font(symbol)
        font_key = font_class.key(options)
        # Check for font in font list.
        unless @document.font_hash.has_key?(font_key)
          # Create font instance.
          @font = font_class.new(@document, options)
          @document.font_hash[font_key] = @font
        else
          # Get font instance from font hash.
          @font = @document.font_hash[font_key]
        end
        @page.set_font(font_key, @font)
      end

      # Write text.
      def text(text)
        raise FontNotSpecifiedError unless @font
        text.split("\n").each_with_index{|token, index|
          decoded_text = decode(token)
          y = trans_y(@page, @pos[1] + @font_size * (index + 1))
          @stream << "BT"
          @stream << "/%s %d Tf" % [@font.name.to_s, @font_size]
          @stream << "%d %d Td" % [@pos[0], y]
          @stream << "%s Tj" % decoded_text
          @stream << "ET"
        }
      end

      private
      # Constantize font by font symbol.
      def constantize_font(symbol)
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

      def decode(text)
        case @font.encoding
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
