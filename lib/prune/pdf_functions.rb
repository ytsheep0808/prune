# coding:utf-8

require "pdf_errors"

module Prune

  # Convert millimeters to points
  def mm2pt(mm)
    mm * 72 / 25.4
  end
end
