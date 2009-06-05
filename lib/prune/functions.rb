# coding:utf-8
module Prune
  module Functions
    # Convert millimeters to points
    def mm2pt(mm)
      mm * 72 / 25.4
    end
  end
end
