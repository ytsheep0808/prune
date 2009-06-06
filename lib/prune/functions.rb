# coding:utf-8
module Prune
  module Functions
    # Convert millimeters to points.
    def mm2pt(mm)
      pt = mm * 72 / 25.4
      (pt * 100).round / 100.0
    end
  end
end
