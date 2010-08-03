module Splunk
  class Parser
    class << self
      def get_parser(parser_type)
        filename = File.join(File.expand_path(File.dirname(__FILE__)), 'parsers', parser_type.to_s + '.rb')
        if File.exist?(filename)
          require filename
        else
          raise 
        end

        class_name = parser_type.to_s.capitalize
        if Splunk::Parsers.const_defined?(class_name)
          Splunk::Parsers.const_get(class_name)
        else
          raise
        end
      end
    end
  end
end
