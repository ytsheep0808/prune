# coding:utf-8

require "prune"

include Prune 

# Initialize pdf document
pdf = Pdf.new(
  :Title => "japanese fonts",
  :Author => "demo",
  :Language => "ja-JP")

font_size = 20
hiragana_1 = "あいうえおかきくけこさしすせそたちつてとなにぬねの"
hiragana_2 = "はひふへほまみむめもやゆよらりるれろわをん"
katakana_1 = "アイウエオカキクケコサシスセソタチツテトナニヌネノ"
katakana_2 = "ハヒフヘホマミムメモヤユヨラリルレロワヲン"
number = "零一二三四五六七八九十百千万億兆"
sentence = "日本語を正しく出力できるPDFライブラリです。"
str = "\n%s\n" %
  [hiragana_1, hiragana_2, katakana_1, katakana_2, number, sentence].join("\n")

# Create page 1
page1 = pdf.add_page(:A4W)
page1.set_font(:ms_gothic, font_size)
page1.puts("MSゴシック" + str)
page1.set_font(:ms_gothic_bold)
page1.puts("MSゴシック＋太字" + str)

# Create page 2
page2 = pdf.add_page(:A4W)
page2.set_font(:ms_gothic_italic, font_size)
page2.puts("MSゴシック＋斜体" + str)
page2.set_font(:ms_gothic_bold_italic)
page2.puts("MSゴシック＋太字＋斜体" + str)

# Save to a file
pdf.save_as("japanese_fonts.pdf")