require 'uploadable'

require 'test/unit'
require 'mocha'

# Uploadable.connect(
#   :host => 'couchdb.kazjote.eu',
#   :database => 'kazjote',
#   :user => 'replikator',
#   :password => 'replikator'
# )

class Note
  include Uploadable::InstanceMethods
  extend Uploadable::ClassMethods

  attr_accessor :name, :content

  uploadable :id => :name, :attributes => [:content]

  def initialize(name = nil, content = nil)
    self.name = name
    self.content = content
  end
end

class UploadableTest < Test::Unit::TestCase

  def test_have_the_same_attributes_as_remote_resource_values
    note = Note.new('funny note', 'funny note content')
    expected_body = {'_id' => 'funny note', 'content' => 'funny note content'}.to_json
    RestClient.expects(:post).with(anything, expected_body, anything)
    note.upload
  end

end
