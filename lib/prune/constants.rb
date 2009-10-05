# coding:utf-8
module Prune
  # Version of Prune.
  VERSION = "0.0.1" unless const_defined?(:VERSION)

  # Application name.
  APPLICATION = self.name unless const_defined?(:APPLICATION)

  # Line feed code.
  LF = "\n" unless const_defined?(:LF)

  # Document sizes(width and height in milli-meters).
  DOCUMENT_SIZES = {
    :A1 => [594.0,  841.0], :A1W => [ 841.0, 594.0],
    :A2 => [420.0,  594.0], :A2W => [ 594.0, 420.0],
    :A3 => [297.0,  420.0], :A3W => [ 420.0, 297.0],
    :A4 => [210.0,  297.0], :A4W => [ 297.0, 210.0],
    :A5 => [148.0,  210.0], :A5W => [ 210.0, 148.0],
    :A6 => [105.0,  148.0], :A6W => [ 148.0, 105.0],
    :A7 => [ 74.0,  105.0], :A7W => [ 105.0,  74.0],
    :B1 => [728.0, 1030.0], :B1W => [1030.0, 728.0],
    :B2 => [515.0,  728.0], :B2W => [ 728.0, 515.0],
    :B3 => [364.0,  515.0], :B3W => [ 515.0, 364.0],
    :B4 => [257.0,  364.0], :B4W => [ 364.0, 257.0],
    :B5 => [182.0,  257.0], :B5W => [ 257.0, 182.0],
    :B6 => [128.0,  182.0], :B6W => [ 182.0, 128.0],
    :B7 => [ 91.0,  128.0], :B7W => [ 128.0,  91.0],
  } unless const_defined?(:DOCUMENT_SIZES)

  # Page layout
  PAGE_LAYOUT = [
    :SinglePage,
    :OneColumn,
    :TwoColumnLeft,
    :TwoColumnRight] unless const_defined?(:PAGE_LAYOUT)
end
