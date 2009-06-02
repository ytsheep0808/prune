# coding:utf-8

module Prune 
  module Elements
    class Catalog < Base
      include Prune

      def initialize(pdf)
        super(pdf)
        @content = pd!(
          pn!(:Type) => pn!(:Catalog),
          pn!(:PageLayout) => pn!(:SinglePage),
          pn!(:Lang) => pl!("ja-JP"),
          pn!(:ViewerPreferences) => pd!(
            pn!(:FitWindow) => true))
        register
      end

      def update(hash)
        hash.keys.each{|key|
          value = hash[key]
          case key
          when pn!(:PageLayout)
            @content[key] = value if PAGE_LAYOUT.include?(value)
          when pn!(:Lang)
            @content[key] = value if value.is_a?(String)
          end
        }
      end

      def outlines=(outlines)
        @content.update(pn!(:Outlines) => outlines)
      end

      def page_layout=(layout)
        if PAGE_LAYOUTS.include?(layout)
          @content.update(pn!(:PageLayout) => layout)
        end
      end

      def lang=(lang)
        @content.update(pn!(:Lang) => lang)
      end

      def pages=(pages)
        @content.update(pn!(:Pages) => pages)
      end
    end
  end
end
