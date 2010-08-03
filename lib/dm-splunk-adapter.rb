require 'rubygems'
require 'dm-core'
require 'dm-core/adapters/abstract_adapter'
require 'connection'

module DataMapper::Adapters
  class SplunkAdapter < AbstractAdapter
    def create(resources)

    end

    def read(query)
      uri  = query.model::URI
      entities = Splunk::Entities.get(uri, @options.merge({
        :data => {:foo => 'bar'}
      }))
puts entities[0]['isDone']
      out = query.filter_records(entities)
      puts out[0]['isDone']
      out
    end

    def update(attributes, collection)
puts "HERE"
      attributes = attributes_as_fields(attributes)
      puts attributes
    end

    def delete(collection)

    end
  end
end
