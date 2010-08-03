require 'connection'
require 'parser'

module Splunk

  DEFAULT_PARSER = 'atom'

  module Entities
    class << self
      def get(path, options={})
        resp = Splunk::Connection.get(path, options).body
        #resp = open(File.join(File.expand_path(File.dirname(__FILE__)),'..','demo','jobs.xml')).read
        parser = Splunk::Parser.get_parser(options['parser'] || Splunk::DEFAULT_PARSER)
        parser.parse(resp)
      end
      
      def post(path, params={}, options={})
        resp = Splunk::Connection.post(path, params, options).body
        puts resp
        Splunk::Parser.get_parser(options['parser'] || Splunk::DEFAULT_PARSER).parse(resp)
      end
    end

  end
end
