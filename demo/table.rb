#!/usr/bin/ruby
# coding:utf-8

require "ruby_pdf_builder"

include RubyPdfBuilder

# Initialize pdf document
pdf = Pdf.new(
  :Title => "table",
  :Author => "demo",
  :Language => "ja-JP")

# Create page 1
page1 = pdf.add_page(:A4W)
page1.set_font(:ms_gothic, 12)
page1.table([10, 20, 30, 40]){|handler|
  handler.cols(
    ["あ\nい\nう\nえ\nお", "かき\nくけ\nこ", "さしす\nせそ", "たちつて\nと"])
  handler.cols(["AB", "CDE", "FGHI", "JKLM\nNOPQ\nRSTU"])
  handler.cols(["0", "1", "2", "3"])
}

# Save to a file
pdf.save_as("table.pdf")