#!/usr/bin/env spec
require 'html_builder'
require 'spec'

describe HtmlBuilder do
  before do
    @builder = HtmlBuilder.new
  end
  
  it "has empty default representation" do
    @builder.to_s.should == ""
  end
  
  it "has representation of a single tag" do
    @builder.p
    @builder.to_s.should == "<p></p>"
  end
  
  it "has representation of nested tags" do
    @builder.html do |html|
      html.p
    end
    @builder.to_s.should == "<html><p></p></html>"
  end
  
  it "has text content" do
    @builder.p do |p|
      p.text "Some text"
    end
    @builder.to_s.should == "<p>Some text</p>"
  end
  
  it "has representation for full size example" do
    @builder.html do |html|
      
    end
  end
end  
