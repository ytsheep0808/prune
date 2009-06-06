# coding:utf-8
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/prune"))
# require "prune"

Prune.pdf("japanese_fonts.pdf"){
  property{
    title "Japanese fonts"
    author "DEMO"
  }

  hiragana = "あいうえおかきくけこさしすせそたちつてとなにぬねの\n"\
    "はひふへほまみむめもやゆよらりるれろわをん"
  katakana = "アイウエオカキクケコサシスセソタチツテトナニヌネノ\n"\
    "ハヒフヘホマミムメモヤユヨラリルレロワヲン"
  numbers = "零一二三四五六七八九十百千万億兆"
  sentence = "Pruneは日本語を正しく出力できるPDFライブラリです。"
  sample = [hiragana, katakana, numbers, sentence].join("\n") + "\n"

  page(:A4W, :font => :ms_gothic, :bold => true, :font_size => 20){
    text "ＭＳゴシック"
    text sample, :font => :ms_gothic
    text "ＭＳゴシック＋太字"
    text sample, :font => :ms_gothic, :bold => true
  }
  
  page(:A4W, :font => :ms_gothic, :bold => true, :font_size => 20){
    text "ＭＳゴシック＋斜体"
    text sample, :font => :ms_gothic, :italic => true
    text "ＭＳゴシック＋太字＋斜体"
    text sample, :font => :ms_gothic, :bold => true, :italic => true
  }
}
