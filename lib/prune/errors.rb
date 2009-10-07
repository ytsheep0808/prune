# coding:utf-8
module Prune
  module Errors
    #===========================================================================
    # Errors for PObjects
    #===========================================================================
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

    #===========================================================================
    # Errors for Elements
    #===========================================================================
    class ElementNotRegisteredError < StandardError; end

    #===========================================================================
    # Errors for Fonts
    #===========================================================================
    # Wrong options for font.
    class FontOptionError < StandardError;end
    # Wrong flags for font descriptor.
    class FontDescriptorFlagError < StandardError;end
    # Ascii font used for non-ascii string.
    class NonAsciiStringError < StandardError;end

    #===========================================================================
    # Errors for Shapes
    #===========================================================================
    class DuplicateIdError < StandardError;end
    # Color format error.
    class ColorFormatError < StandardError;end
    # Line argument error.
    class LineArgumentError < StandardError;end
    # Line style error.
    class LineStyleError < StandardError;end
    # Rectangle argument error.
    class RectangleArgumentError < StandardError;end
    # Rectangle style error.
    class RectangleStyleError < StandardError;end
    # Unexisting font.
    class UnexistingFontError < StandardError;end
    # Font not Specified.
    class FontNotSpecifiedError < StandardError;end
    # Font mode error.
    class FontModeError < StandardError;end
    # Text align should be :left, :center, or :right.
    class TextAlignError < StandardError;end

    #===========================================================================
    # Errors for Document
    #===========================================================================
    # Document has no pages.
    class DocumentEmptyError < StandardError; end

    #===========================================================================
    # Errors for Parsers
    #===========================================================================
    # Invalid PDF version.
    class PdfVersionError < StandardError;end
  end
end
