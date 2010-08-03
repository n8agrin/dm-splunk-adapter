$:.push(File.expand_path(File.join(File.dirname(__FILE__), "../lib")))

require 'rubygems'
require 'dm-core'
require 'dm-splunk-adapter'
require 'entities'
require 'models/job'

DataMapper.setup(:default, {
    :adapter    => 'splunk',
    :host       => 'tui.splunk.com',
    :port       => 8089,
    :user       => 'admin',
    :password   => 'changeme'
})

DataMapper.finalize

b = Splunk::Model::Job.all
a = b[0]
puts a.sid
puts a.isDone
puts a.label
puts a.earliestTime
puts b.save

##Splunk::Model::Job.get(1)
#o = {
#    'user' => 'admin',
#    'password' => 'changeme',
#    'host' => 'tui.splunk.com',
#    'headers' => {
#
#    }
#}
#require 'time'
#s = Time.now
#Splunk::Connection.get('/services/search/jobs', {:foo => 'bar'}, o).body
#puts Time.now - s
#s = Time.now
#Splunk::Connection.get('/services/search/jobs', o).body
#puts Time.now - s
#s = Time.now
#Splunk::Connection.get('/services/search/jobs', o).body
#puts Time.now - s
