# This module should use RestClient to communicate with CouchDB. See 'notes'
# script for simple usecase.
#
# It is used to save your custom objects to CouchDB database.
#
# It will require RestClient and JSON gems:
#
#   sudo gem install restclient json

require 'rubygems'
require 'restclient'
require 'json'

module Uploadable
  def self.connect(configuration)
  end

  module InstanceMethods
    # Saves object attributes to database.
    def upload
    end
  end

  module ClassMethods
    # Options is a hash with following keys:
    #  :id =>         :attribute_name  - attribute which will be used to generate id
    #  :attributes => array_of_symbols - attributes which will be saved and retrieved
    #                                    to/from database
    def uploadable(options)
    end

    # Creates and initializates new object instance from database.
    def download(id)
    end
  end
end

