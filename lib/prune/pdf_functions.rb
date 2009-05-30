# coding:utf-8

require "pdf_errors"

module RubyPdfBuilder
  # Convert millimeters to points
  def mm2pt(mm)
    mm * 72 / 25.4
  end

  # Convert font symbols to font class name
  def font_sym_to_class_name(font_sym)
    font_str = font_sym.to_s
    # This symbol consists of only alphabets and underscores
    raise UnexistingFontError unless
      /\A[a-z][a-z_]*[a-z]\z/ === font_str
    # This symbol should contain only one underscore at a time
    raise UnexistingFontError if
      /_{2,}/ === font_str
    # Convert underscored string to camel-case string
    pos = 0
    while (index = font_str.index(/_/, pos))
      font_str[index, 2] = font_str[index + 1, 1].upcase
      pos = index + 1
    end
    font_str[0, 1] = font_str[0, 1].upcase
    font_str
  end
end
