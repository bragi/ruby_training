require 'rubygems'
require 'restclient'
require 'json'

module Uploadable
  module InstanceMethods
    def upload
      klass = self.class
      serialized = klass.uploadable_attributes.inject({}) do |hash, attribute|
        hash.update(attribute => send(attribute))
      end
      serialized['_id'] = send(klass.uploadable_id_attribute)

      RestClient.post(123, serialized.to_json, 123)
    end
  end

  module ClassMethods
    attr_accessor :uploadable_id_attribute, :uploadable_attributes

    def uploadable(options)
      self.uploadable_id_attribute = options[:id]
      self.uploadable_attributes = options[:attributes]
    end
  end
end
