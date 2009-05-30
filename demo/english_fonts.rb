# coding:utf-8

require "prune"

include Prune 

# Initialize pdf document
pdf = Pdf.new(
  :Title => "english fonts",
  :Author => "demo",
  :Language => "en-US")

font_size = 24
alphabet = "abcdefghijklmnopqrstuvwxyz"
number = "0123456789"
str = "\n" + alphabet + " " + number + "\n" + alphabet.upcase + "\n"

# Create page 1
page1 = pdf.add_page(:A4W)
page1.set_font(:courier, font_size)
page1.puts("Courier" + str)
page1.set_font(:courier_bold)
page1.puts("Courier Bold" + str)
page1.set_font(:courier_bold_oblique)
page1.puts("Courier Bold Oblique" + str)
page1.set_font(:courier_oblique)
page1.puts("Courier Oblique" + str)

## Creage page 2
page2 = pdf.add_page(:A4W)
page2.set_font(:helvetica, font_size)
page2.puts("Helvetica" + str)
page2.set_font(:helvetica_bold)
page2.puts("Helvetica Bold" + str)
page2.set_font(:helvetica_bold_oblique)
page2.puts("Helvetica Bold Oblique" + str)
page2.set_font(:helvetica_oblique)
page2.puts("Helvetica Oblique" + str)

## Create page 3
page3 = pdf.add_page(:A4W)
page3.set_font(:times_roman, font_size)
page3.puts("Times Roman" + str)
page3.set_font(:times_bold)
page3.puts("Times Bold" + str)
page3.set_font(:times_bold_italic)
page3.puts("Times Bold Italic" + str)
page3.set_font(:times_italic)
page3.puts("Times Italic" + str)

str2 = alphabet + " " + number + "\n" + alphabet.upcase + "\n"

page4 = pdf.add_page(:A4W)
page4.set_font(:helvetica, font_size)
page4.puts("Symbol")
page4.set_font(:symbol)
page4.puts(str2)
page4.set_font(:helvetica)
page4.puts("Zapf Dingbats")
page4.set_font(:zapf_dingbats)
page4.puts(str2)

# Save to a file
pdf.save_as("english_fonts.pdf")