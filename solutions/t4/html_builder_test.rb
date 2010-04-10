#!/usr/bin/env spec
require 'html_builder'
require 'spec'

describe HtmlBuilder do
  before do
    @builder = HtmlBuilder.new
  end
  
  it "has empty default representation" do
    @builder.to_html.should == ""
  end
end  
