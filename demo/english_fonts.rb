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

  page(:A4W, :font => :helvetica, :font_size => 30){
    div "* Courier"
    div sample, :font => :courier
    div "* Courier Bold"
    div sample, :font => :courier, :bold => true
    div "* Courier Italic"
    div sample, :font => :courier, :italic => true
    div "* Courier Bold Italic"
    div sample, :font => :courier, :bold => true, :italic => true
  }

  page(:A4W, :font => :helvetica, :font_size => 30){
    div "* Helvetica"
    div sample
    div "* Helvetica Bold"
    div sample, :bold => true
    div "* Helvetica Italic"
    div sample, :italic => true
    div "* Helvetica Italic"
    div sample, :bold => true, :italic => true
  }

  page(:A4W, :font => :helvetica, :font_size => 30){
    div "* Times Roman"
    div sample, :font => :times_roman
    div "* Times Roman Bold"
    div sample, :font => :times_roman, :bold => true
    div "* Times Roman Italic"
    div sample, :font => :times_roman, :italic => true
    div "* Times Roman Bold Italic"
    div sample, :font => :times_roman, :bold => true, :italic => true
  }

  page(:A4W, :font => :helvetica, :font_size => 30){
    div "* Symbol"
    div sample, :font => :symbol
    div "* Zapf Dingbats"
    div sample, :font => :zapf_dingbats
  }
}
