#!/usr/bin/env spec

# Uses Behaviour Driven Development via RSpec (http://rspec.info/)
#
# Install RSpec using:
#   gem install rspec
#
# Run examples within this file:
#   spec html_builder_spec.rb
#
# To list all examples run via:
#   spec -f specdoc html_builder_spec.rb

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

    it "has representation for full size example" do
      @builder.html do |html|
        html.head do |head|
          head.title "Hello World!"
        end
        html.body do |body|
          body.h1 "Hello World!"
          body.p do |p|
            p.text "Hello "
            p.strong "Everyone"
            p.text "!"
          end
        end
      end
    end
  end
end  
