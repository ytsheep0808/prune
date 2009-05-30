# coding:utf-8
require File.join(File.dirname(__FILE__), "../../spec_helper.rb")

describe Prune::PdfType::PdfDictionary do
  before(:each) do
    @dictionary = PdfDictionary.new(
      :one => 1, :two => 2, :three => 3, :Type => "Dictionary")
  end

  it "should be empty when initialized without arguments" do
    dictionary = PdfDictionary.new
    dictionary.should be_empty
  end

  it "should work the same as Hash" do
    # Hash.[]
    @dictionary[:three].should be_eql(3)
    @dictionary[:two].should be_eql(2)
    @dictionary[:one].should be_eql(1)
    @dictionary[:zero].should be_nil
    # Hash.[]=
    @dictionary[:one] = 10
    @dictionary[:two] = 200
    @dictionary[:three] = 3000
    @dictionary[:three].should be_eql(3000)
    @dictionary[:two].should be_eql(200)
    @dictionary[:one].should be_eql(10)
    @dictionary[:zero] = 0
    # Hash.has_key?
    @dictionary.should have_key(:one)
    @dictionary.should have_key(:two)
    @dictionary.should have_key(:three)
    @dictionary.should have_key(:zero)
    @dictionary.should_not have_key(:four)
    # Hash.update
    @dictionary.update(:three => 333, :four => 4444)
    @dictionary.should have_key(:four)
    @dictionary[:three].should be_eql(333)
    @dictionary[:four].should be_eql(4444)
  end

  it "should return sorted keys" do
    @dictionary.keys.should be_eql([:Type, :one, :three, :two])
  end

  it "should return formatted string" do
    lines = @dictionary.to_s.split(/\n/)
    lines[0].should be_eql("<<")
    lines[1].should be_eql("  /Type (Dictionary)")
    lines[2].should be_eql("  /one 1")
    lines[3].should be_eql("  /three 3")
    lines[4].should be_eql("  /two 2")
    lines[5].should be_eql(">>")
  end
end
