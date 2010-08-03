require 'uri'
require 'rubygems'
require 'patron'

module Splunk
  
  class AuthorizationException < Exception; end
  class NotFoundException < Exception; end
  
  module Connection
   
    DEFAULT_SCHEME= 'https' 
    DEFAULT_HOST  = 'localhost'
    DEFAULT_PORT  = 8089
    AUTH_ENDPOINT = '/services/auth/login'
    UNSAFE_ENTITIES = /[^-_.!~*'a-zA-Z\d:@$,\[\]]/n
    
    class << self

        def request(method, path, options={})
          conn = Patron::Session.new
          conn.base_url = gen_base_uri(options)
          conn.insecure = options[:ssl_secure] ? !options[:ssl_secure] : true
          options[:headers] ||= {}
puts "Splunk base url #{conn.base_url}"
puts "Splunk path #{path}"
          if method == :get
            resp = conn.get(path, options[:headers])
          elsif method == :post
puts "Splunk body #{options['body']}"
            resp = conn.post(path, options['body'], options[:headers])
          end

          # Handle status responses
          raise Splunk::AuthorizationException if resp.status == 401
          raise Splunk::NotFoundException if resp.status == 404

          resp
        end
        
        def get(path, options={})
          request(:get, path, options)
        end
        
        def post(path, body={}, options={})
          options['body'] = to_query(body)
          request(:post, path, options)
        end

        def to_query(options)
          options.keys.inject('') do |query_string, key|
            query_string << '&' unless key == options.keys.first
            query_string << "#{URI.escape(key.to_s, Splunk::Connection::UNSAFE_ENTITIES)}=#{URI.escape(options[key], Splunk::Connection::UNSAFE_ENTITIES)}"
          end    
        end

        private
        def gen_base_uri(options)
            uri             = URI::HTTP.new(*[nil]*9)
            uri.scheme      = options['scheme'] ? options['scheme'] : self::DEFAULT_SCHEME
            uri.host        = options['host'] ? options['host'] : self::DEFAULT_HOST
            uri.port        = options['port'] ? options['port'] : self::DEFAULT_PORT
            uri.query       = to_query(options['query']) unless options['query'].nil?
            uri.user        = options['user']
            uri.password    = options['password']
            uri.to_s
        end
    end              
  end
end
