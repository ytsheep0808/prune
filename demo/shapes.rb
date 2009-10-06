# coding:utf-8
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/prune"))
# require "prune"

Prune.pdf("shapes.pdf"){
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
rect 5.0, -305.0, 15.0, -15.0, :fill => true, :fill_color => "#FF0000"
rect 5.0, 305.0, 15.0, 15.0,  :fill => true, :fill_color => "#00FF00"
rect 5.0, 305.0, 15.0, -15.0, :fill => true, :fill_color => "#0000FF"
rect 5.0, -305.0, 15.0, 15.0, :fill => true, :fill_color => "#FFFF00"


rect 5.0, 500.0, 15.0, 15.0,  :fill => true, :fill_color => "#00FFFF"
rect 5.0, 580.0, 15.0, 15.0,  :fill => true, :fill_color => "#00FFFF"
  }
}
