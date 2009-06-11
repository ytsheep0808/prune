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
  sample = alphabets + " " + numbers + "\n" + alphabets.upcase

  page(:A4W, :font => {:name => :helvetica, :size => 30}){
    div "* Courier"
    div sample, :font => {:name => :courier}
    br
    div "* Courier Bold"
    div sample, :font => {:name => :courier, :bold => true}
    br
    div "* Courier Italic"
    div sample, :font => {:name => :courier, :italic => true}
    br
    div "* Courier Bold Italic"
    div sample, :font => {:name => :courier, :bold => true, :italic => true}
  }

  page(:A4W, :font => {:name => :helvetica, :size => 30}){
    div "* Helvetica"
    div sample
    br
    div "* Helvetica Bold"
    div sample, :font => {:bold => true}
    br
    div "* Helvetica Italic"
    div sample, :font => {:italic => true}
    br
    div "* Helvetica Italic"
    div sample, :font => {:bold => true, :italic => true}
  }

  page(:A4W, :font => {:name => :helvetica, :size => 30}){
    div "* Times Roman"
    div sample, :font => {:name => :times_roman}
    br
    div "* Times Roman Bold"
    div sample, :font => {:name => :times_roman, :bold => true}
    br
    div "* Times Roman Italic"
    div sample, :font => {:name => :times_roman, :italic => true}
    br
    div "* Times Roman Bold Italic"
    div sample,
      :font => {:name => :times_roman, :bold => true, :italic => true}
  }

  page(:A4W, :font => {:name => :helvetica, :size => 30}){
    div "* Symbol"
    div sample, :font => {:name => :symbol}
    br
    div "* Zapf Dingbats"
    div sample, :font => {:name => :zapf_dingbats}
  }
}
