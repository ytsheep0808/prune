# coding:utf-8
require File.join(File.dirname(__FILE__), "../../spec_helper.rb")

describe Prune::PObjects::PArray do
  include Prune::PObjects

  it "should be empty when initialized without arguments" do
    array = pa!
    array.should be_empty
  end

  it "should work the same as Array" do
    array = pa!(pl!("a"), 1, pl!("b"), pn!(:symbol))
    # Array.[]
    array[0].should == pl!("a")
    array[1].should == 1
    array[2].should == pl!("b")
    array[3].should == pn!(:symbol)
    array[4].should be_nil
    array[5].should be_nil
    # Array.[]=
    array[1] = 11111
    array[2] = pl!("ARRAY")
    array[1].should == 11111
    array[2].should == pl!("ARRAY")
    array[4] = 10
    array[4].should be_eql(10)
    # Array.<<
    array << pl!("ADDED")
    array[5].should == pl!("ADDED")
  end

  it "should return formatted string" do
    number_array = (1..33).to_a
    array = pa!(*number_array)
    lines = array.to_s.split(/\n/)
    lines[0].should == "[ 1 2 3 4 5 6 7 8 9 10"
    lines[1].should == "  11 12 13 14 15 16 17 18 19 20"
    lines[2].should == "  21 22 23 24 25 26 27 28 29 30"
    lines[3].should == "  31 32 33 ]"
    array = pa!(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
    array.to_s.should == "[ 1 2 3 4 5 6 7 8 9 10 ]"
    array = pa!(4, 3, 2, 1)
    array.to_s.should == "[ 4 3 2 1 ]"
  end
end
