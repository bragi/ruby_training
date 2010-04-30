require 'uploadable'

require 'test/unit'
require 'mocha'


class Book
  include Uploadable::InstanceMethods
  extend Uploadable::ClassMethods

  attr_accessor :name, :title

  def initialize(name = nil, title = nil)
    self.name = name if name
    self.title = title if title
  end

  uploadable :id => :name, :attributes => [:title]
end

class UploadableTest < Test::Unit::TestCase

  def setup
    Uploadable.connect(
      :host => 'example.com',
      :database => 'lrug',
      :user => 'tom',
      :password => 'tom123'
    )

    @book = Book.new('book name', 'book title')
  end

  def test_upload_object_to_database
    RestClient.expects(:post)
    @book.upload
  end

  def test_use_correct_url_string_during_connection
    RestClient.expects(:post).
      with('http://tom:tom123@example.com/lrug', anything, anything)
    @book.upload
  end

  def test_send_object_attributes_during_upload
    expected_body = {'_id' => "Book:#{@book.name}", :title => @book.title}.to_json
    expected_headers = {:content_type => 'json', :accept => 'json'}
    RestClient.expects(:post).
      with('http://tom:tom123@example.com/lrug', expected_body, expected_headers)
    @book.upload
  end

  def test_set_correct_attributes_during_download
    response = mock("book", :body => {'_id' => "Book:#{@book.name}", :title => @book.title}.to_json)
    RestClient.expects(:get).
      with("http://tom:tom123@example.com/lrug/Book:#{@book.name}", anything).
      returns(response)

    downloaded_book = Book.download(@book.name)
    assert_equal @book.name, downloaded_book.name
    assert_equal @book.title, downloaded_book.title
  end
end

