# coding:utf-8

require "pdf_object/base_object"

module Prune 
  module PdfObject
    class Catalog < BaseObject
      def initialize(pdf)
        super(pdf)
        @content = PdfDictionary.new(
          :Type => :Catalog,
          :PageLayout => :SinglePage,
          :Lang => "ja-JP",
          :ViewerPreferences => PdfDictionary.new(
            :FitWindow => true))
        register
      end

      def update(hash)
        hash.keys.each{|key|
          value = hash[key]
          case key
          when :PageLayout
            @content[key] = value if PAGE_LAYOUT.include?(value)
          when :Lang
            @content[key] = value if value.is_a?(String)
          end
        }
      end

      def outlines=(outlines)
        @content.update(:Outlines => outlines)
      end

      def page_layout=(layout)
        if PAGE_LAYOUTS.include?(layout)
          @content.update(:PageLayout => layout)
        end
      end

      def lang=(lang)
        @content.update(:Lang => lang)
      end

      def pages=(pages)
        @content.update(:Pages => pages)
      end
    end
  end
end
