require 'rubygems'
require 'active_support'

begin
  require 'libxml'
  ActiveSupport::XmlMini.backend = 'LibXML'
rescue LoadError
  begin
    require 'nokogiri'
    ActiveSupport::XmlMini.backend = 'Nokogiri'
  rescue LoadError
  end
end


module Splunk
  module Parsers
    class Atom
      class << self
        def parse(xml)
          parsed = ActiveSupport::XmlMini.parse(xml)
          if parsed.has_key?('feed')
            parse_feed(parsed)
          elsif parsed.has_key?('entry')
            [parse_entry(parsed['entry'])]
          end 
        end

        def parse_feed(hash)
           out = []
           hash['feed']['entry'].each do |entry|
             out << parse_entry(entry)
           end
           out
        end

        def parse_entry(hash)
          entry = {}
          hash.each_pair do |key, val|
            if key == 'author' && val.has_key?('name')
                entry['author'] = val['name']['__content__']
            elsif key == 'link'
                entry['links'] = val
            elsif key == 'content'
                entry.merge!(parse_dict(val))
            else
                if val.has_key?('__content__')
                    entry[key] = val['__content__']
                end
            end
          end
          entry
        end
  
        private
        def parse_dict(dict)
          out = {}
          dict = dict['dict'] if dict.has_key?('dict')
          if dict.has_key?('key')
            dict['key'] = [dict['key']] if dict['key'].class == Hash
            dict['key'].each do |key|
              if key.has_key?('__content__')
                out[key['name']] = key['__content__']
              elsif key.has_key?('dict')
                out[key['name']] = parse_dict(key['dict'])
              elsif key.has_key?('list')
                out[key['name']] = parse_list(key['list'])
              end
            end        
          end
          out
        end
      
        def parse_list(list)
          out = []
          return out unless list.has_key?('item')
          list['item'] = [list['item']] if list['item'].class == Hash
          list['item'].each do |item|
            if item.has_key?('__content__')
              out.push(item['__content__'])
            elsif item.has_key?('dict')
              out.push(parse_dict(item['dict']))
            elsif item.has_key?('list')
              out.push(parse_list(item['list']))
            end
          end
        end
      end
    end
  end
end

