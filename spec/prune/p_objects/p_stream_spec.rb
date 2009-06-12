# coding:utf-8
require File.join(File.dirname(__FILE__), "../../spec_helper.rb")

describe Prune::PObjects::PStream do
  include Prune::PObjects

  before(:each) do
    @stream = ps
  end

  it "should be correct length" do
    begin_size = "stream\n".size
    end_size = "endstream".size
    @stream << "ABC"
    @stream.length.should be_eql(begin_size + end_size + 4)
    @stream << "DEFGH"
    @stream.length.should be_eql(begin_size + end_size + 10)
  end

  it "should return formatted string" do
    @stream << "ABC"
    @stream << "DEFGH"
    lines = @stream.to_s.split(/\n/)
    lines[0].should be_eql("stream")
    lines[1].should be_eql("ABC")
    lines[2].should be_eql("DEFGH")
    lines[3].should be_eql("endstream")
  end
end
