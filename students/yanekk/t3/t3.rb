#!/usr/bin/env ruby

# Install Sinatra framework:
#     sudo gem install sinatra
#
# Documentation:
#  * http://www.sinatrarb.com/
#  * http://railsapi.com/doc/sinatra-v1.0/
#
# Simple labyrinth game implemented as web application running at http://localhost:4567/
#
# Starting on a home page it presents user with a short description of his
# locations and available paths he can take (as links).
#
# When gamer gets to last location he is presented with a "YOU'RE WINNER !"
# congratulations text.
#
# YANEKK Started at: 2010-03-30 12:45
# YANEKK   Ended at: 2010-03-30 13:04

require 'rubygems'
require 'sinatra'

class Node
  def self.next_id
    @@id = 0 if !defined? @@id
    @@id += 1
  end

  def initialize(title, text)

    @title = title.to_s
    @text  = text.to_s
    @id    = Node.next_id
    @exits = {}
    Node.add_node self

  end

  def self.reset
    @@id    = 0
    @@nodes = {}
  end

  def self.add_node(node)
    @@nodes = {} if !defined? @@nodes
    @@nodes[node.id] = node
  end

  def self.find(id)
    @@nodes[id]
  end

  attr_accessor :id
  attr_accessor :title
  attr_accessor :text
  attr_accessor :exits

  def add_exit(text, node)
    @exits[text] = node
  end

  def finish?
    return true if @exits.size == 0
    false
  end

  def first
    return @@nodes.first
  end
end

class NodeView
  def initialize(node)
    @node = node
  end
  def to_html

    %Q[<html>
<head>
  <title>#{@node.title}</title>
</head>
<body>
  <h1>#{@node.title}</h1>
  <h2>Welcome to labirynth</h2>
  <p>#{@node.text}</p>
  #{exits_to_html}
</body>
    ]
  end
  def exits_to_html
    if(@node.exits.size > 0)
      @node.exits.map {|direction, node| "<li><a href=\"/node/#{node.id}\">#{direction}</a></li>"}
    else
      "<p>YOU'RE WINNER !</p>"
    end
  end
end

get "/" do
  "Welcome to labyrinth"
end

get "/node/:id" do
  node = Node.find(params[:id])
  NodeView.new(node).to_html
end

