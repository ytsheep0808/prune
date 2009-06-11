# coding:euc-jp
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/prune"))
# require "prune"

Prune.pdf("japanese_encodings_euc_jp.pdf"){
  property{
    title "Japanese encodings EUC-JP"
    subject "Demonstration document for Prune."
    author "Prune"
    language "ja-JP"
  }

  hiragana = "�����������������������������������ĤƤȤʤˤ̤ͤ�\n"\
    "�ϤҤդؤۤޤߤ��������������"
  katakana = "�����������������������������������ĥƥȥʥ˥̥ͥ�\n"\
    "�ϥҥեإۥޥߥ��������������"
  alphabets = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
  numbers = "����󻰻͸�ϻ��Ȭ�彽ɴ��������"
  sentence = "Prune�����ܸ�����������ϤǤ���PDF�饤�֥��Ǥ���"
  sample = [
    hiragana, katakana, alphabets, numbers, sentence
  ].join("\n") + "\n"

  page(:A4W, :font => {:name => :ms_gothic, :bold => true, :size => 20}){
    div "EUC�Ǥ����ܸ����"
    div sample, :font => {:bold => false}
  }
}
