# coding:utf-8

module Prune 
  class UnknownEncodingError < StandardError; end
  class ObjectNotRegisteredError < StandardError; end
  class BlockNotGivenError < StandardError; end
  class TableFormatError < StandardError; end
  class ArgumentError < StandardError; end
  class DocumentSizeError < StandardError; end
  class ColorFormatError < StandardError; end
  class FontNotSpecifiedError < StandardError; end
  class UnexistingFontError < StandardError; end
  class MalFormedDocumentError < StandardError; end
  class MalFormedPageError < StandardError; end
  class UnknownPageError < StandardError; end
  class PositionFormatError < StandardError; end
end
