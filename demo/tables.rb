# coding:utf-8
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/prune"))
# require "prune"

Prune.pdf("tables.pdf"){
  property{
    title "Tables"
    subject "Demonstration document for Prune."
    author "Prune"
    language "ja-JP"
  }

  page(:A4W, :font => {:name => :ms_gothic, :size => 12}){
    table(:font => {:size => 20}, :border => {:style => :solid}){
      tr{
        text = []
        5.times do
          text << "num"
          td text.join("\n")
        end
      }
      tr{
        text = []
        4.times do
          text << "num"
          td text.join("\n"),
            :border => {:style => :dashed, :color => "#FF0000", :width => 2.0}
        end
      }
    }

    br

    table(:widths => [50, 100, 150, 200, 150], :font => {:size => 20}, :border => {:style => :solid}){
      tr{
        text = []
        5.times do
          text << "num"
          td text.join("\n")
        end
      }
      tr(:widths => [150, 150, 200, 150]){
        text = []
        4.times do
          text << "num"
          td text.join("\n"),
            :border => {:style => :dashed, :color => "#FF0000", :width => 2.0}
        end
      }
    }
  }
}
