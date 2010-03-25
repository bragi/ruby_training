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

require 'rubygems'
require 'sinatra'

class Node
  @@next_id = 1
  @@nodes = {}

  def self.reset
    @@next_id = 1
    @@nodes = {}
  end
  
  def self.add_node(node)
    node.id = @@next_id
    @@nodes[node.id] = node
    @@next_id += 1
  end
  
  def self.find(id)
    @@nodes[id.to_i]
  end
  
  attr_accessor :id
  attr_accessor :title
  attr_accessor :text
  attr_accessor :exits
  
  def initialize(title, text)
    self.title = title
    self.text = text
    self.exits= {}
    Node.add_node(self)
  end
  
  def add_exit(text, node)
    exits[text] = node
  end
  
  def finish?
    exits.empty?
  end
end

Start = Node.new "Welcome traveler", "Welcome to labyrinth. Select your path"
Left =  Node.new "Left path", "You are on a left path"
Right =  Node.new "Right path", "You are on a right path"
Finish = Node.new "Finish", "You have reached the destination"

Start.add_exit("Go left", Left)
Start.add_exit("Go right", Right)

Left.add_exit("Go straight", Finish)
Left.add_exit("Go right", Right)

Right.add_exit("Go straight", Finish)
Right.add_exit("Go left", Left)

class NodeView
  attr_reader :node
  
  def initialize(node)
    @node = node
  end
  
  def node_link(text, node)
    %Q{<a href="/node/#{node.id}">#{text}</a>}
  end

  def exits
    exits = node.exits.map {|text, node| node_link(text, node)}.map{|link| "<li>#{link}</li>"}.join("\n      ")
    "<ul>
      #{exits}
    </ul>"
  end
  
  def congratulations
    "<p>YOU'RE WINNER !</p>
    <p><a href='/'>Start again</a></p>"
  end
  
  def exits_or_congratulations
    node.finish? ? congratulations : exits
  end

  def template
<<-HTML
<!doctype html>
<html>
  <head>
    <title>#{node.title}</title>
  </head>
  <body>
    <h1>#{node.title}</h1>
    <p>#{node.text}</p>
    #{exits_or_congratulations}
  </body>
</html>
HTML
  end
  
  alias to_html template
end

get "/" do
  NodeView.new(Start).to_html
end

get "/node/:id" do
  node = Node.find(params[:id])
  NodeView.new(node).to_html
end
