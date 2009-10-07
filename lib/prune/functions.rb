# coding:utf-8
module Prune
  module Functions
    # Convert millimeter to points.
    def mm_to_pt(mm)
      pt = mm * 72.0 / 25.4
      (pt * 100).round / 100.0
    end

    # Convert points to millimeter.
    def pt_to_mm(pt)
      mm = pt * 25.4 / 72.0
      (mm * 100).round / 100.0
    end
  end
end
