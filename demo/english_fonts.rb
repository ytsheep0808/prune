# coding:utf-8
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/prune"))
# require "prune"

Prune.pdf("english_fonts.pdf"){
  property{
    title "English fonts"
    subject "Demonstration document for Prune."
    author "Prune"
    language "en-US"
  }

  alphabets = "abcdefghijklmnopqrstuvwxyz"
  numbers = "0123456789"
  sample = alphabets + " " + numbers + "\n" + alphabets.upcase + "\n"

  page(:A4W, :font => :helvetica, :font_size => 30, :bold => true){
    text "* Courier"
    text sample, :font => :courier
    text "* Courier Bold"
    text sample, :font => :courier, :bold => true
    text "* Courier Italic"
    text sample, :font => :courier, :italic => true
    text "* Courier Bold Italic"
    text sample, :font => :courier, :bold => true, :italic => true
  }

  page(:A4W, :font => :helvetica, :font_size => 30, :bold => true){
    text "* Helvetica"
    text sample, :font => :helvetica
    text "* Helvetica Bold"
    text sample, :font => :helvetica, :bold => true
    text "* Helvetica Italic"
    text sample, :font => :helvetica, :italic => true
    text "* Helvetica Italic"
    text sample, :font => :helvetica, :bold => true, :italic => true
  }

  page(:A4W, :font => :helvetica, :font_size => 30, :bold => true){
    text "* Times Roman"
    text sample, :font => :times_roman
    text "* Times Roman Bold"
    text sample, :font => :times_roman, :bold => true
    text "* Times Roman Italic"
    text sample, :font => :times_roman, :italic => true
    text "* Times Roman Bold Italic"
    text sample, :font => :times_roman, :bold => true, :italic => true
  }

  page(:A4W, :font => :helvetica, :font_size => 30, :bold => true){
    text "* Symbol"
    text sample, :font => :symbol
    text "* Zapf Dingbats"
    text sample, :font => :zapf_dingbats
  }
}
