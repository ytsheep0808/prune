# coding:shift_jis
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/prune"))
# require "prune"

Prune.pdf("japanese_encodings_shift_jis.pdf"){
  property{
    title "Japanese encodings Shift JIS"
    subject "Demonstration document for Prune."
    author "Prune"
    language "ja-JP"
  }

  hiragana = "あいうえおかきくけこさしすせそたちつてとなにぬねの\n"\
    "はひふへほまみむめもやゆよらりるれろわをん"
  katakana = "アイウエオカキクケコサシスセソタチツテトナニヌネノ\n"\
    "ハヒフヘホマミムメモヤユヨラリルレロワヲン"
  alphabets = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
  numbers = "零一二三四五六七八九十百千万億兆"
  sentence = "Pruneは日本語を正しく出力できるPDFライブラリです。"
  sample = [
    hiragana, katakana, alphabets, numbers, sentence
  ].join("\n") + "\n"

  page(:A4W, :font => :ms_gothic, :bold => true, :font_size => 20){
    div "Shift-JISでの日本語出力"
    div sample, :bold => false
  }
}
