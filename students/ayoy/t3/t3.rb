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
  @@nodes = Array.new

  def initialize(title, text)
    self.title = title
    self.text = text
    self.exits = {}
    Node.add_node self
  end

  def self.reset
    @@nodes.clear
  end
  
  def self.add_node(node)
    @@nodes.push node
    node.id = @@nodes.size
  end
  
  def self.find(id)
    @@nodes[id.to_i-1]
  end
  
  attr_accessor :id
  attr_accessor :title
  attr_accessor :text
  attr_accessor :exits
  
  def add_exit(text, node)
    exits[text] = node
  end
  
  def finish?
    exits.empty?
  end
end

class NodeView
  def initialize(node)
    @node = node
  end

  def node_link(text, id)
    %Q(<a href="/node/#{id}">#{text}</a>)
  end

  def body
    if @node.finish?
      "<p>YOU'RE WINNER !</p>
      <p><a href='/'>Start again</a></p>"
    else
      exits_html = @node.exits.map { |text,node| "<li>#{node_link(text, node.id)}</li>"}.
                   join("\n      ")
      "<ul>
      #{exits_html}
      </ul>"
    end
  end

  def to_html
<<-END
<html>
  <head>
    <title>#{@node.title}</title>
  </head>
  <body>
    <h1>#{@node.title}</h1>
    <p>#{@node.text}</p>
    #{body}
  </body>
</html>
END
  end
end

Start = Node.new "Welcome traveller", "Welcome to labyrinth. Choose your path"
Right = Node.new "Right path", "You are on a right path"
Left = Node.new "Left path", "You are on a left path"
Finish = Node.new "Finish", "You have reached the destination"

Start.add_exit("Go right", Right)
Start.add_exit("Go left", Left)

Right.add_exit("Go straight", Finish)
Right.add_exit("Go back", Start)

Left.add_exit("Go back", Start)

get "/" do
  NodeView.new(Start).to_html
end

get "/node/:id" do
  node = Node.find(params[:id])
  NodeView.new(node).to_html
end
