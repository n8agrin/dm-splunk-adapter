require 'rubygems'
require 'dm-core'
require 'dm-core/adapters/abstract_adapter'
require 'connection'

module DataMapper::Adapters
  class SplunkAdapter < AbstractAdapter
    
    def create(resources)
      puts "create"
      name = self.name
      resources.each do |resource|
        # initialize_serial(resource, rand(2**32))
        uri = resource.class::URI
        resp = Splunk::Entities.post(uri, resource.attributes(:field), @options.to_hash)
        puts resp
        if resource.methods.include?('update_from_create')
          resource.send(:update_from_create, resp)
        end
      end
    end

    def read(query)
      puts "read"
      uri  = query.model::URI
      entities = Splunk::Entities.get(uri, @options.to_hash)
      query.filter_records(entities)
    end

    def update(attributes, collection)
      attributes = attributes_as_fields(attributes)
      puts attributes
    end

    def delete(collection)

    end
  end
end
