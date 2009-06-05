# coding:utf-8

module Prune 
  module Elements
    class Catalog < Base
      include Prune

      def initialize(document)
        super(document)
        @content = pd!(
          pn!(:Type) => pn!(:Catalog),
          pn!(:PageLayout) => pn!(:SinglePage),
          pn!(:Lang) => pl!("ja-JP"),
          pn!(:ViewerPreferences) => pd!(
            pn!(:FitWindow) => true))
        register
      end

      def outlines=(reference)
        @content.update(pn!(:Outlines) => reference)
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
