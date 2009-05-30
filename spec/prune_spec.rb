# coding: utf-8

require File.dirname(__FILE__) + '/spec_helper.rb'

describe Prune do
  it "should have constant VERSION" do
    Prune::VERSION.should be_a(String)
    Prune::VERSION.should match(/\A\d+\.\d+\.\d\z/)
  end

  it "should have constant APPLICATION" do
    Prune::APPLICATION.should be_a(String)
    Prune::APPLICATION.should eql("Prune")
  end

  it "should have constant LF" do
    Prune::LF.should be_a(String)
    Prune::LF.should eql("\n")
  end

  it "should have constant DOCUMENT_SIZE" do
    Prune::DOCUMENT_SIZE.should be_a(Hash)
    Prune::DOCUMENT_SIZE.should be_frozen
    size_A = (1..7).collect{|n| ["A#{n}".to_sym, "A#{n}W".to_sym]}.flatten
    Prune::DOCUMENT_SIZE.keys.should include(*size_A)
    size_B = (1..7).collect{|n| ["B#{n}".to_sym, "B#{n}W".to_sym]}.flatten
    Prune::DOCUMENT_SIZE.keys.should include(*size_B)
  end

  it "should have constant PAGE_LAYOUT" do
    Prune::PAGE_LAYOUT.should be_an(Array)
    Prune::PAGE_LAYOUT.should be_frozen
    layouts = [:SinglePage, :OneColumn, :TwoColumnLeft, :TwoColumnRight]
    Prune::PAGE_LAYOUT.should include(*layouts)
  end
end
