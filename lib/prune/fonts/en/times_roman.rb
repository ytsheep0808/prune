# coding:utf-8
module Prune
  module Fonts
    # Times Roman font.
    class TimesRoman < BaseEn
      class << self
        def key(options)
          key = font_name
          key << "_bold" if bold?(options)
          key << "_italic" if italic?(options)
          PObjects.pn(key)
        end
      end

      WIDTHS = [
        250, 250, 250, 250, 250, 250, 250, 250, 250, 250,
        250, 250, 250, 250, 250, 250, 250, 250, 250, 250,
        250, 250, 250, 250, 250, 250, 250, 250, 250, 250,
        250, 250, 250, 333, 408, 500, 500, 833, 778, 180,
        333, 333, 500, 564, 250, 333, 250, 278, 500, 500,
        500, 500, 500, 500, 500, 500, 500, 500, 278, 278,
        564, 564, 564, 444, 921, 722, 667, 667, 722, 611,
        556, 722, 722, 333, 389, 722, 611, 889, 722, 722,
        556, 722, 667, 556, 611, 722, 722, 944, 722, 722,
        611, 333, 278, 333, 469, 500, 333, 444, 500, 444,
        500, 444, 333, 500, 500, 278, 278, 500, 278, 778,
        500, 500, 500, 500, 333, 389, 278, 500, 500, 722,
        500, 500, 444, 480, 200, 480, 541, 350, 500, 350,
        333, 500, 444, 1000, 500, 500, 333, 1000, 556, 333,
        889, 350, 611, 350, 350, 333, 333, 444, 444, 350,
        500, 1000, 333, 980, 389, 333, 722, 350, 444, 722,
        250, 333, 500, 500, 500, 500, 200, 500, 333, 760,
        276, 500, 564, 333, 760, 333, 400, 564, 300, 300,
        333, 500, 453, 250, 333, 300, 310, 500, 750, 750,
        750, 444, 722, 722, 722, 722, 722, 722, 889, 667,
        611, 611, 611, 611, 333, 333, 333, 333, 722, 722,
        722, 722, 722, 722, 722, 564, 722, 722, 722, 722,
        722, 722, 556, 500, 444, 444, 444, 444, 444, 444,
        667, 444, 444, 444, 444, 444, 278, 278, 278, 278,
        500, 500, 500, 500, 500, 500, 500, 564, 500, 500,
        500, 500, 500, 500, 500, 500
      ] unless const_defined?(:WIDTH)

      BOLD_WIDTHS = [
        250, 250, 250, 250, 250, 250, 250, 250, 250, 250,
        250, 250, 250, 250, 250, 250, 250, 250, 250, 250,
        250, 250,	250, 250, 250, 250, 250, 250, 250, 250,
        250, 250, 250, 333, 555, 500, 500, 1000, 833, 278,
        333, 333, 500, 570, 250, 333, 250, 278, 500, 500,
        500, 500, 500, 500, 500, 500, 500, 500, 333, 333,
        570, 570, 570, 500, 930, 722, 667, 722, 722, 667,
        611, 778, 778, 389, 500, 778, 667, 944, 722, 778,
        611, 778, 722, 556, 667, 722, 722, 1000, 722, 722,
        667, 333, 278, 333, 581, 500, 333, 500, 556, 444,
        556, 444, 333, 500, 556, 278, 333, 556, 278, 833,
        556, 500, 556, 556, 444, 389, 333, 556, 500, 722,
        500, 500, 444, 394, 220, 394, 520, 350, 500, 350,
        333, 500, 500, 1000, 500, 500, 333, 1000, 556, 333,
        1000, 350, 667, 350, 350, 333, 333, 500, 500, 350,
        500, 1000, 333, 1000, 389, 333, 722, 350, 444, 722,
        250, 333, 500, 500, 500, 500, 220, 500, 333, 747,
        300, 500, 570, 333, 747, 333, 400, 570, 300, 300,
        333, 556, 540, 250, 333, 300, 330, 500, 750, 750,
        750, 500, 722, 722, 722, 722, 722, 722, 1000, 722,
        667, 667, 667, 667, 389, 389, 389, 389, 722, 722,
        778, 778, 778, 778, 778, 570, 778, 722, 722, 722,
      	722, 722, 611, 556, 500, 500, 500, 500, 500, 500,
        722, 444, 444, 444, 444, 444, 278, 278, 278, 278,
        500, 556, 500, 500, 500, 500, 500, 570, 500, 556,
        556, 556, 556, 500, 556, 500
      ] unless const_defined?(:BOLD_WIDTHS)

      ITALIC_WIDTHS = [
        250, 250, 250, 250, 250, 250, 250, 250, 250, 250,
        250, 250, 250, 250, 250, 250, 250, 250, 250, 250,
        250, 250, 250, 250, 250, 250, 250, 250, 250, 250,
        250, 250, 250, 333, 420, 500, 500, 833, 778, 214,
        333, 333, 500, 675, 250, 333, 250, 278, 500, 500,
        500, 500, 500, 500, 500, 500, 500, 500, 333, 333,
        675, 675, 675, 500, 920, 611, 611, 667, 722, 611,
        611, 722, 722, 333, 444, 667, 556, 833, 667, 722,
        611, 722, 611, 500, 556, 722, 611, 833, 611, 556,
        556, 389, 278, 389, 422, 500, 333, 500, 500, 444,
        500, 444, 278, 500, 500, 278, 278, 444, 278, 722,
        500, 500, 500, 500, 389, 389, 278, 500, 444, 667,
        444, 444, 389, 400, 275, 400, 541, 350, 500, 350,
        333, 500, 556, 889, 500, 500, 333, 1000, 500, 333,
        944, 350, 556, 350, 350, 333, 333, 556, 556, 350,
        500, 889, 333, 980, 389, 333, 667, 350, 389, 556,
        250, 389, 500, 500, 500, 500, 275, 500, 333, 760,
        276, 500, 675, 333, 760, 333, 400, 675, 300, 300,
        333, 500, 523, 250, 333, 300, 310, 500, 750, 750,
        750, 500, 611, 611, 611, 611, 611, 611, 889, 667,
        611, 611, 611, 611, 333, 333, 333, 333, 722, 667,
        722, 722, 722, 722, 722, 675, 722, 722, 722, 722,
        722, 556, 611, 500, 500, 500, 500, 500, 500, 500,
        667, 444, 444, 444, 444, 444, 278, 278, 278, 278,
        500, 500, 500, 500, 500, 500, 500, 675, 500, 500,
        500, 500, 500, 444, 500, 444
      ] unless const_defined?(:ITALIC_WIDTHS)

      BOLD_ITALIC_WIDTHS = [
        250, 250, 250, 250, 250, 250, 250, 250, 250, 250,
        250, 250, 250, 250, 250, 250, 250, 250, 250, 250,
        250, 250, 250, 250, 250, 250, 250, 250, 250, 250,
        250, 250, 250, 389, 555, 500, 500, 833, 778, 278,
        333, 333, 500, 570, 250, 333, 250, 278, 500, 500,
        500, 500, 500, 500, 500, 500, 500, 500, 333, 333,
        570, 570, 570, 500, 832, 667, 667, 667, 722, 667,
        667, 722, 778, 389, 500, 667, 611, 889, 722, 722,
        611, 722, 667, 556, 611, 722, 667, 889, 667, 611,
        611, 333, 278, 333, 570, 500, 333, 500, 500, 444,
        500, 444, 333, 500, 556, 278, 278, 500, 278, 778,
        556, 500, 500, 500, 389, 389, 278, 556, 444, 667,
        500, 444, 389, 348, 220, 348, 570, 350, 500, 350,
        333, 500, 500, 1000, 500, 500, 333, 1000, 556, 333,
        944, 350, 611, 350, 350, 333, 333, 500, 500, 350,
        500, 1000, 333, 1000, 389, 333, 722, 350, 389, 611,
        250, 389, 500, 500, 500, 500, 220, 500, 333, 747,
        266, 500, 606, 333, 747, 333, 400, 570, 300, 300,
        333, 576, 500, 250, 333, 300, 300, 500, 750, 750,
        750, 500, 667, 667, 667, 667, 667, 667, 944, 667,
        667, 667, 667, 667, 389, 389, 389, 389, 722, 722,
        722, 722, 722, 722, 722, 570, 722, 722, 722, 722,
        722, 611, 611, 500, 500, 500, 500, 500, 500, 500,
        722, 444, 444, 444, 444, 444, 278, 278, 278, 278,
        500, 556, 500, 500, 500, 500, 500, 570, 500, 556,
        556, 556, 556, 444, 500, 444
      ] unless const_defined?(:BOLD_ITALIC_WIDTHS)

      def initialize(document, options = {})
        super(document)
        @font_name = :times_roman
        self.name = self.class.key(options)
        @bold = bold?(options)
        @italic = italic?(options)
        if @bold && @italic
          self.base_font = pn("Times-BoldItalic")
        elsif @bold
          self.base_font = pn("Times-Bold")
        elsif @italic
          self.base_font = pn("Times-Italic")
        else
          self.base_font = pn("Times-Roman")
        end
      end

      # Get width of the text.
      def width(string, font_size)
        string_base_width = string.bytes.inject(0){|result, byte|
          if @bold && @italic
            byte_width = BOLD_ITALIC_WIDTHS[byte] || 1000
          elsif @bold
            byte_width = BOLD_WIDTHS[byte] || 1000
          elsif @italic
            byte_width = ITALIC_WIDTHS[byte] || 1000
          else
            byte_width = WIDTHS[byte] || 1000
          end
          result + byte_width
        }
        string_base_width * font_size / 1000
      end
    end
  end
end
