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
    div "ＭＳゴシック"
    div sample, :bold => false
    div "ＭＳゴシック＋太字"
    div sample
  }
  
  page(:A4W, :font => :ms_gothic, :bold => true, :font_size => 30){
    div "ＭＳゴシック＋斜体"
    div sample, :bold => false, :italic => true
    div "ＭＳゴシック＋太字＋斜体"
    div sample, :italic => true
  }
}
