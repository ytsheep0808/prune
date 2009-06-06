# coding:utf-8
require "prune"

Prune.pdf("english_fonts.pdf"){
  properties{
    description{
      title "English fonts"
      author "DEMO"
    }
  }

  font_size = 24
  alphabet = "abcdefghijklmnopqrstuvwxyz"
  number = "0123456789"
  str = "\n" + alphabet + " " + number + "\n" + alphabet.upcase + "\n"

  page(:A4W){
    font :courier, :size => font_size
    text str
    font :courier, :size => font_size, :bold => true
    text str
    font :courier, :size => font_size, :italic => true
    text str
    font :courier, :size => font_size, :bold => true, :italic => true
    text str
  }
}
