# coding:utf-8
module Prune 
  module Elements
    class Catalog < Base
      include Prune

      # Initialize.
      def initialize(document)
        super(document)
        # Set dictionary.
        @content = pd(
          pn(:Type) => pn(:Catalog),
          pn(:PageLayout) => pn(:SinglePage),
          pn(:Lang) => pl("ja-JP"),
          pn(:ViewerPreferences) => pd(
            pn(:FitWindow) => true))
        # Register element to document.
        register
      end

      # Set reference to outlines.
      def outlines=(reference)
        @content.update(pn(:Outlines) => reference)
      end

      # Set page layout.
      def page_layout=(layout)
        if PAGE_LAYOUTS.include?(layout)
          @content.update(pn(:PageLayout) => layout)
        end
      end

      # Set lang.
      def lang=(lang)
        @content[pn(:Lang)] = lang
      end

      # Set pdf version.
      def version=(version)
        @content[pn(:Version)] = version
      end

      # Set reference to pages.
      def pages=(pages)
        @content[pn(:Pages)] = pages
      end
    end
  end
end
