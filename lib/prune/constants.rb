# coding:utf-8
module Prune
  # Version of Prune.
  VERSION = "0.0.1"

  # Application name.
  APPLICATION = self.name

  # 改行コード
  LF = "\n"
  # ドキュメントの大きさ
  DOCUMENT_SIZE = {
    :A1 => [0, 0, 594,  841].freeze, :A1W => [0, 0,  841, 594].freeze,
    :A2 => [0, 0, 420,  594].freeze, :A2W => [0, 0,  594, 420].freeze,
    :A3 => [0, 0, 297,  420].freeze, :A3W => [0, 0,  420, 297].freeze,
    :A4 => [0, 0, 210,  297].freeze, :A4W => [0, 0,  297, 210].freeze,
    :A5 => [0, 0, 148,  210].freeze, :A5W => [0, 0,  210, 148].freeze,
    :A6 => [0, 0, 105,  148].freeze, :A6W => [0, 0,  148, 105].freeze,
    :A7 => [0, 0,  74,  105].freeze, :A7W => [0, 0,  105,  74].freeze,
    :B1 => [0, 0, 728, 1030].freeze, :B1W => [0, 0, 1030, 728].freeze,
    :B2 => [0, 0, 515,  728].freeze, :B2W => [0, 0,  728, 515].freeze,
    :B3 => [0, 0, 364,  515].freeze, :B3W => [0, 0,  515, 364].freeze,
    :B4 => [0, 0, 257,  364].freeze, :B4W => [0, 0,  364, 257].freeze,
    :B5 => [0, 0, 182,  257].freeze, :B5W => [0, 0,  257, 182].freeze,
    :B6 => [0, 0, 128,  182].freeze, :B6W => [0, 0,  182, 128].freeze,
    :B7 => [0, 0,  91,  128].freeze, :B7W => [0, 0,  128,  91].freeze,
  }.freeze
  # ページレイアウト
  PAGE_LAYOUT = [
    :SinglePage,
    :OneColumn,
    :TwoColumnLeft,
    :TwoColumnRight].freeze
end
