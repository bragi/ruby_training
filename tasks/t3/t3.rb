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
  def self.reset
  end
  
  def self.add_node(node)
  end
  
  def self.find(id)
  end
  
  attr_accessor :id
  attr_accessor :title
  attr_accessor :text
  attr_accessor :exits
  
  def add_exit(text, node)
  end
  
  def finish?
  end
end

class NodeView
  def to_html
  end
end

get "/" do
end

get "/node/:id" do
  node = Node.find(params[:id])
  NodeView.new(node).to_html
end
