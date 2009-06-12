# coding:utf-8
require File.join(File.dirname(__FILE__), "../../spec_helper.rb")

describe Prune::PObjects::PDictionary do
  include Prune::PObjects

  before(:each) do
    @dictionary = pd(
      pn(:one) => 1,
      pn(:two) => 2,
      pn(:three) => 3,
      pn(:Type) => pl("Dictionary"))
  end

  it "should be empty when initialized without arguments" do
    dictionary = pd
    dictionary.should be_empty
  end

  it "should work the same as Hash" do
    # Hash.[]
    @dictionary[pn(:three)].should == 3
    @dictionary[pn(:two)].should == 2
    @dictionary[pn(:one)].should == 1
    @dictionary[pn(:zero)].should be_nil
    # Hash.[]=
    @dictionary[pn(:one)] = 10
    @dictionary[pn(:two)] = 200
    @dictionary[pn(:three)] = 3000
    @dictionary[pn(:three)].should == 3000
    @dictionary[pn(:two)].should == 200
    @dictionary[pn(:one)].should == 10
    @dictionary[pn(:zero)] = 0
    # Hash.has_key?
    @dictionary.should have_key(pn(:one))
    @dictionary.should have_key(pn(:two))
    @dictionary.should have_key(pn(:three))
    @dictionary.should have_key(pn(:zero))
    @dictionary.should_not have_key(pn(:four))
    # Hash.update
    @dictionary.update(pn(:three) => 333, pn(:four) => 4444)
    @dictionary.should have_key(pn(:four))
    @dictionary[pn(:three)].should == 333
    @dictionary[pn(:four)].should == 4444
  end

  it "should return sorted keys" do
    @dictionary.keys.should ==
      [pn(:Type), pn(:one), pn(:three), pn(:two)]
  end

  it "should return formatted string" do
    lines = @dictionary.to_s.split(/\n/)
    lines[0].should == "<<"
    lines[1].should == "  /Type (Dictionary)"
    lines[2].should == "  /one 1"
    lines[3].should == "  /three 3"
    lines[4].should == "  /two 2"
    lines[5].should == ">>"
  end
end
