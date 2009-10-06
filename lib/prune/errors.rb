# coding:utf-8
module Prune
  module Errors
    class UnknownEncodingError < StandardError; end
    class ElementNotRegisteredError < StandardError; end
    class BlockNotGivenError < StandardError; end
    class TableFormatError < StandardError; end
    class DocumentSizeError < StandardError; end
    class ColorFormatError < StandardError; end


    class MalFormedDocumentError < StandardError; end
    class MalFormedPageError < StandardError; end
    class UnknownPageError < StandardError; end
    class PositionFormatError < StandardError; end
    # Invalid PDF version.
    class PdfVersionError < StandardError;end

    # Invalid position.
    class InvalidPositionError < StandardError;end
    # Invalid position operation.
    class InvalidPositionOperationError < StandardError;end

    # PDictionary can update with only PDictionary.
    class PDictionaryTypeError < StandardError;end
    # PDictionary key should be PName.
    class PDictionaryKeyError < StandardError;end
    # PHexadecimalString's content should be a String.
    class PHexadecimalStringTypeError < StandardError;end
    # PHexadeciamlString's content should consist of /[0-9A-F]+/.
    class PHexadecimalStringContentError < StandardError;end
    # PLiteralString's content should be a String.
    class PLiteralStringTypeError < StandardError;end
    # PName's content should be a String or a Symbol.
    class PNameTypeError < StandardError;end
    # PStream's content should be a String.
    class PStreamTypeError < StandardError;end

    # Wrong options for font.
    class FontOptionError < StandardError;end
    # Wrong flags for font descriptor.
    class FontDescriptorFlagError < StandardError;end
    # Position error.
    class PositionError < StandardError;end
    # Color error.
    class ColorError < StandardError;end
    # Font mode error.
    class FontModeError < StandardError;end
    # Ascii font used for non-ascii string.
    class NonAsciiStringError < StandardError;end
    # Hankaku katakana used for string.
    class HankakuKatakanaError < StandardError;end
    # Text align should be :left, :center, or :right.
    class TextAlignError < StandardError;end
    # Errors on options for border.
    class BorderOptionError < StandardError;end

    #===========================================================================
    # Errors for Shapes
    #===========================================================================
    class DuplicateIdError < StandardError;end
    # Color format error.
    class ColorFormatError < StandardError;end
    # Line option error.
    class LineOptionError < StandardError;end
    # Rectangle option error.
    class RectangleOptionError < StandardError;end
    # Line style error.
    class LineStyleError < StandardError;end
    # Unexisting font.
    class UnexistingFontError < StandardError;end
    # Font not Specified.
    class FontNotSpecifiedError < StandardError;end
  end
end
