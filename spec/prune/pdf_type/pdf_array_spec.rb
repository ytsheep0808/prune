# coding:utf-8
require File.join(File.dirname(__FILE__), "../../spec_helper.rb")

describe Prune::PdfType::PdfArray do
  it "should be empty when initialized without arguments" do
    array = PdfArray.new
    array.should be_empty
  end

  it "should work the same as Array" do
    array = PdfArray.new(["a", 1, "b", :symbol])
    # Array.[]
    array[0].should be_eql("a")
    array[1].should be_eql(1)
    array[2].should be_eql("b")
    array[3].should be_eql(:symbol)
    array[4].should be_nil
    array[5].should be_nil
    # Array.[]=
    array[1] = 11111
    array[2] = "ARRAY"
    array[1].should be_eql(11111)
    array[2].should be_eql("ARRAY")
    array[4] = 10
    array[4].should be_eql(10)
    # Array.<<
    array << "ADDED"
    array[5].should be_eql("ADDED")
  end

  it "should return formatted string" do
    array = PdfArray.new((1..33).to_a)
    lines = array.to_s.split(/\n/)
    lines[0].should be_eql("[ 1 2 3 4 5 6 7 8 9 10")
    lines[1].should be_eql("  11 12 13 14 15 16 17 18 19 20")
    lines[2].should be_eql("  21 22 23 24 25 26 27 28 29 30")
    lines[3].should be_eql("  31 32 33 ]")
    array = PdfArray.new((1..10).to_a)
    array.to_s.should be_eql("[ 1 2 3 4 5 6 7 8 9 10 ]")
    array = PdfArray.new([4, 3, 2, 1])
    array.to_s.should be_eql("[ 4 3 2 1 ]")
  end
end
