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
        # Add page to pages.
        @document.pages << @page
      end

      # Set font.
      def font(symbol, options = {})
        @font_size = options[:size] || 12
        @font_color = options[:color] || "000000"
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
    end
  end
end
