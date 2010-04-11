#!/usr/bin/env spec
require 'html_builder'
require 'spec'

describe HtmlBuilder do
  before do
    @builder = HtmlBuilder.new
  end
  
  context "when presented as string" do
    it "is an empty string" do
      @builder.to_s.should == ""
    end

    it "is a single tag" do
      @builder.p
      @builder.to_s.should == "<p></p>"
    end

    it "has nested tags" do
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
    
    it "has text shorthand" do
      @builder.p "Some text"
      @builder.to_s.should == "<p>Some text</p>"
    end

    it "nests tags and text" do
      @builder.p do |p|
        p.text "This "
        p.strong do |strong|
          strong.text "is in bold"
        end
        p.text "!"
      end
      @builder.to_s.should == "<p>This <strong>is in bold</strong>!</p>"
    end
  end
end  
