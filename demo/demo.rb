$:.push(File.expand_path(File.join(File.dirname(__FILE__), "../lib")))

require 'rubygems'
require 'dm-core'
require 'dm-splunk-adapter'
require 'entities'
require 'models/job'
require 'time'

DataMapper.setup(:default, {
    :adapter    => 'splunk',
    :host       => 'tui.splunk.com',
    :port       => 8089,
    :user       => 'admin',
    :password   => 'changeme'
})


j = Splunk::Model::Job.create(:search => 'search index=_internal')
puts j.id
puts j.sid
puts j.key
10.times do
  sleep(1)
  now = Time.now
  j.reload
  puts j.event_count
  puts Time.now - now
end

# puts "SID #{j.sid}"

# puts j.id
# puts j.attribute_loaded?(:id)
# puts j.original_attributes
# puts j.is_done

# puts j.is_done
# puts j.sid
# puts j.search

# b = Splunk::Model::Job.all(:is_done => false)
# 
# b.each do |a|
#   puts a.event_count
# # puts "SID           => #{a.sid}"
# # puts "Is done?      => #{a.is_done?}"
# # puts "Label         => #{a.label}"
# # puts "Earliest time => #{a.earliest_time}"
# # puts a.done_progress
# end
