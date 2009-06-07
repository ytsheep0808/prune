# coding:utf-8
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/prune"))
# require "prune"

Prune.pdf("japanese_fonts.pdf"){
  property{
    title "Japanese fonts"
    subject "Demonstration document for Prune."
    author "Prune"
    language "ja-JP"
  }

  hiragana = "あいうえおかきくけこさしすせそたちつてとなにぬねの\n"\
    "はひふへほまみむめもやゆよらりるれろわをん"
  katakana = "アイウエオカキクケコサシスセソタチツテトナニヌネノ\n"\
    "ハヒフヘホマミムメモヤユヨラリルレロワヲン"
  numbers = "零一二三四五六七八九十百千万億兆"
  sentence = "Pruneは日本語を正しく出力できるPDFライブラリです。"
  sample = [hiragana, katakana, numbers, sentence].join("\n") + "\n"

  page(:A4W, :font => :ms_gothic, :bold => true, :font_size => 30){
    text "ＭＳゴシック"
    text sample, :bold => false
    text "ＭＳゴシック＋太字"
    text sample
  }
  
  page(:A4W, :font => :ms_gothic, :bold => true, :font_size => 30){
    text "ＭＳゴシック＋斜体"
    text sample, :bold => false, :italic => true
    text "ＭＳゴシック＋太字＋斜体"
    text sample, :italic => true
  }
}
