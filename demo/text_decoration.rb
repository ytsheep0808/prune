# coding:utf-8
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/prune"))
# require "prune"

Prune.pdf("text_decoration.pdf"){
  property{
    title "Text decoration"
    subject "Demonstration document for Prune."
    author "Prune"
    language "ja-JP"
  }

  page(:A4W, :font => :ms_gothic, :font_size => 30){
    div "青色の文字", :fill_color => "#0000FF"
    div "赤で縁取られた文字", :stroke_color => "#FF0000", :font_mode => :stroke
    div "緑で縁取られて内側が黄色の文字",
      :stroke_color => "#00FF00", :fill_color => "#FFFF00",
      :font_mode => :fill_and_stroke
    div "赤で縁取られて内側が青で太字、斜体な文字",
      :bold => true, :italic => true,
      :stroke_color => "#FF0000", :fill_color => "#0000FF",
      :font_mode => :fill_and_stroke
    span "赤色の文字", :fill_color => "#FF0000"
    span "黄色の文字", :fill_color => "#FFFF00"
    span "青色の文字", :fill_color => "#0000FF"
    br
    span "赤色の文字", :fill_color => "#FF0000"
    span "黄色の文字", :fill_color => "#FFFF00"
    span "青色の文字", :fill_color => "#0000FF"
  }
}
