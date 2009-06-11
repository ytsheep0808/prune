# coding:shift_jis
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/prune"))
# require "prune"

Prune.pdf("japanese_encodings_shift_jis.pdf"){
  property{
    title "Japanese encodings Shift JIS"
    subject "Demonstration document for Prune."
    author "Prune"
    language "ja-JP"
  }

  hiragana = "�����������������������������������ĂƂȂɂʂ˂�\n"\
    "�͂Ђӂւق܂݂ނ߂��������������"
  katakana = "�A�C�E�G�I�J�L�N�P�R�T�V�X�Z�\�^�`�c�e�g�i�j�k�l�m\n"\
    "�n�q�t�w�z�}�~����������������������������"
  alphabets = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
  numbers = "����O�l�ܘZ������\�S�疜����"
  sentence = "Prune�͓��{��𐳂����o�͂ł���PDF���C�u�����ł��B"
  sample = [
    hiragana, katakana, alphabets, numbers, sentence
  ].join("\n") + "\n"

  page(:A4W, :font => :ms_gothic, :bold => true, :font_size => 20){
    div "Shift-JIS�ł̓��{��o��"
    div sample, :bold => false
  }
}
