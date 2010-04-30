require 'rubygems'
require 'restclient'
require 'json'

module Uploadable

  HEADERS = {:content_type => 'json', :accept => 'json'}

  class << self
    attr_accessor :configuration
  end

  def self.connect(configuration)
    @configuration = configuration
  end

  def self.database_uri
    ["http://#{configuration[:user]}:#{configuration[:password]}",
      "#{configuration[:host]}/#{configuration[:database]}"].join("@")
  end

  def self.id(klass, id_attribute_value)
    "#{klass}:#{id_attribute_value}"
  end

  module InstanceMethods
    def upload
      klass = self.class

      serialized = klass.uploadable_attributes.inject({}) do |hash, attribute|
        hash.update(attribute => send(attribute))
      end
      serialized['_id'] = Uploadable.id(klass, send(klass.uploadable_id_attribute))

      RestClient.post(Uploadable.database_uri, serialized.to_json, Uploadable::HEADERS)
    end
  end

  module ClassMethods
    attr_accessor :uploadable_id_attribute, :uploadable_attributes

    def uploadable(options)
      self.uploadable_id_attribute = options[:id]
      self.uploadable_attributes = options[:attributes]
    end

    def download(id)
      object = self.new

      resource_id = Uploadable.id(self, id)
      response = RestClient.get("#{Uploadable.database_uri}/#{resource_id}")
      object_data = JSON.parse(response.body)

      uploadable_id = object_data['_id'].gsub("#{self}:", '')
      object.send("#{uploadable_id_attribute}=", uploadable_id)

      uploadable_attributes.each do |attribute|
        object.send("#{attribute}=", object_data[attribute.to_s])
      end

      object
    end
  end
end

