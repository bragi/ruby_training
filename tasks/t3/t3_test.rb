require 't3'
require 'test/unit'
require 'rack/test'

class NodeTest < Test::Unit::TestCase
  def setup
    Node.reset
  end
  
  def test_create_with_title_and_text
    Node.new("Title", "Text")
  end
  
  def test_have_id_when_created
    node = Node.new("Title", "Text")
    assert_equal 1, node.id
  end
  
  def test_have_title_when_created
    node = Node.new("Title", "Text")
    assert_equal "Title", node.title
  end

  def test_have_text_when_created
    node = Node.new("Title", "Text")
    assert_equal "Text", node.text
  end

  def test_have_subsequent_ids_when_multiple_created
    n1 = Node.new("Title1", "Text1")
    n2 = Node.new("Title2", "Text2")
    assert_equal 1, n1.id
    assert_equal 2, n2.id
  end
  
  def test_can_be_found_by_id
    n1 = Node.new("Title1", "Text1")
    assert_equal n1, Node.find(n1.id)
  end
  
  def test_have_exits
    n1 = Node.new("Title1", "Text1")
    n2 = Node.new("Title2", "Text2")
    assert_equal 0, n1.exits.length
    n1.add_exit("forward", n2)
    assert_equal 1, n1.exits.length
    assert_equal n2, n1.exits["forward"]
  end
  
  def test_is_finish_when_has_no_exits
    n1 = Node.new("Title1", "Text1")
    assert_equal 0, n1.exits.length
    assert n1.finish?
  end
  
  def test_is_not_finish_when_has_exits  
    n1 = Node.new("Title1", "Text1")
    n2 = Node.new("Title2", "Text2")
    n1.add_exit("forward", n2)
    assert_equal 1, n1.exits.length
    assert !n1.finish?
  end
end

class NodeViewTest < Test::Unit::TestCase
  def setup
    Node.reset
    @start = Node.new("Start", "Start node")
    @finish = Node.new("Finish", "Finish node")
    @start.add_exit "forward", @finish
    
    @start_view = NodeView.new(@start)
    @finish_view = NodeView.new(@finish)
  end
  
  def test_have_title
    assert %r{<title>Start</title>} =~ @start_view.to_html
  end
  
  def test_have_header
    assert %r{<h1>Start</h1>} =~ @start_view.to_html
  end
  
  def test_have_text
    assert %r{<p>Start node</p>} =~ @start_view.to_html
  end

  def test_have_exits
    assert %r{<li><a href="/node/#{@finish.id}">forward</a></li>} =~ @start_view.to_html
  end

  def test_have_congratulations
    assert %r{<p>YOU'RE WINNER !</p>} =~ @finish_view.to_html
  end
end

class WebApplicationTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_have_start_page
    get "/"
    assert last_response.ok?
    assert /Welcome to labyrinth/ =~ last_response.body
  end
end