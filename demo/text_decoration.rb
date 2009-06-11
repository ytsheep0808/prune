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

  page(:A4W, :font => {:name => :ms_gothic, :size => 30}){
    div "青色の文字",
      :font => {:fill_color => "#0000FF"}
    div "赤で縁取られた文字",
      :font => {:mode => :stroke, :stroke_color => "#FF0000"}
    div "緑で縁取られて内側が黄色の文字",
      :font => {:mode => :fill_and_stroke,
        :stroke_color => "#00FF00", :fill_color => "#FFFF00"}
    div "赤で縁取られて内側が青で太字、斜体な文字",
      :font => {:bold => true, :italic => true,
        :font_mode => :fill_and_stroke,
        :stroke_color => "#FF0000", :fill_color => "#0000FF"}
    span "赤色の文字", :font => {:fill_color => "#FF0000"}
    span "黄色の文字", :font => {:fill_color => "#FFFF00"}
    span "青色の文字", :font => {:fill_color => "#0000FF"}
    br
    span "紫色の文字", :font => {:fill_color => "#800080"}
    span "灰色の文字", :font => {:fill_color => "#808080"}
    span "緑色の文字", :font => {:fill_color => "#008000"}
    br
    div "背景色が設定された文字列", :background_color => "#FFFF00"
    br
    div "左寄せ", :text_align => :left, :background_color => "#FF0000"
    div "センタリング", :text_align => :center, :background_color => "#FFFF00"
    div "右寄せ", :text_align => :right, :background_color => "#0000FF"
  }
  page(:A4W, :font => {:name => :ms_gothic, :size => 30}){
    div "枠をつけてみる", :text_align => :center,
      :border => {:style => :solid}
    br
    div "破線で\n枠をつけてみる", :text_align => :center,
      :border => {:style => :dashed, :width => 2.0, :color => "#00FF00"}
    br
    div "全ての枠に\n違うスタイルを\n適用する", :text_align => :right,
      :border_top => {:style => :solid, :width => 2.0, :color => "#FF0000"},
      :border_left => {:style => :dashed, :width => 1.0, :color => "#00FF00"},
      :border_right => {:style => :solid},
      :border_bottom => {:style => :dashed, :color => "#0000FF"}
  }
}
