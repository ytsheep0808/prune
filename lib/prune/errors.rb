# coding:utf-8

module Prune
  module Errors
    # Invalid PDF version
    class PdfVersionError < StandardError;end

    # Unexisting font
    class UnexistingFontError < StandardError;end
    # Font not Specified
    class FontNotSpecifiedError < StandardError;end
    # PDictionary can update with only PDictionary
    class PDictionaryTypeError < StandardError;end
    # PDictionary key should be PName
    class PDictionaryKeyError < StandardError;end
    # PHexadecimalString's content should be a String.
    class PHexadecimalStringTypeError < StandardError;end
    # PHexadeciamlString's content should consist of [0-9A-F]+
    class PHexadecimalStringContentError < StandardError;end
    # PLiteralString's content should be a String.
    class PLiteralStringTypeError < StandardError;end
    # PName's content should be a String or a Symbol.
    class PNameTypeError < StandardError;end
    # PStream's content should be a String.
    class PStreamTypeError < StandardError;end
  end
end
