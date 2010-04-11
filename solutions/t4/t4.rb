#!/usr/bin/env ruby

# Creates a nice html page in file given as argument or outputs to console
# when no file name given

require 'html_builder'

html = HtmlBuilder.new("html")
html.head do |head|
  head.title "Hello World!"
end
html.body do |body|
  body.h1 "Hello World!"
  body.p do |p|
    p.text "Hello "
    p.strong "everybody"
    p.text "!"
  end
end

if file_name = ARGV.first
  File.open(file_name, "w") do |f|
    f << html.to_s
  end
else
  puts html.to_s
end
