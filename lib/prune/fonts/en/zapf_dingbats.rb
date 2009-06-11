# coding:utf-8
module Prune
  module Fonts
    # Zapf dingbats font.
    class ZapfDingbats < BaseEn
      class << self
        def key(options)
          FontOptionError if bold?(options) || italic?(options)
          PObjects.pn!(font_name)
        end
      end

      WIDTHS = [
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0,	0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 278, 974, 961, 974, 980, 719, 789, 790,
        791, 690, 960, 939,	549, 855, 911, 933, 911, 945,
        974, 755, 846, 762, 761, 571, 677, 763, 760, 759,
        754, 494, 552, 537, 577, 692, 786, 788, 788, 790,
        793, 794, 816, 823, 789, 841, 823, 833, 816, 831,
        923, 744, 723, 749, 790, 792, 695, 776,	768, 792,
        759, 707, 708, 682, 701, 826, 815, 789, 789, 707,
        687, 696, 689, 786, 787, 713, 791, 785, 791, 873,
        761, 762, 762, 759, 759, 892, 892, 788, 784, 438,
        138, 277, 415, 392, 392, 668, 668, 0, 390, 390,
        317, 317, 276, 276, 509, 509, 410, 410, 234, 234,
        334, 334, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0,	0, 0, 0, 0, 0, 0,
        0, 732, 544, 544, 910, 667, 760, 760, 776, 595,
        694, 626, 788, 788, 788, 788,	788, 788, 788, 788,
        788, 788, 788, 788, 788, 788, 788, 788, 788, 788,
        788, 788, 788, 788, 788, 788, 788, 788,	788, 788,
        788, 788, 788, 788, 788, 788, 788, 788, 788, 788,
        788, 788, 894, 838, 1016, 458, 748, 924, 748, 918,
        927, 928, 928, 834, 873, 828, 924, 924, 917, 930,
        931, 463, 883, 836, 836, 867, 867, 696, 696, 874,
        0, 874,	760, 946, 771, 865, 771, 888, 967, 888,
        831, 873, 927, 970, 918, 0
      ] unless const_defined?(:WIDTHS)

      def initialize(document, options = {})
        super(document)
        self.name = self.class.key(options)
        self.base_font = pn!(:ZapfDingbats)
      end

      # Get width of the text.
      def width(string, font_size)
        string_base_width = string.bytes.inject(0){|result, byte|
          byte_width = WIDTHS[byte] || 1000
          result + byte_width
        }
        string_base_width * font_size / 1000
      end
    end
  end
end
