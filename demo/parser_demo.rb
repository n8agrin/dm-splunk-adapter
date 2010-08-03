
$:.push(File.expand_path(File.join(File.dirname(__FILE__), "../lib")))

require 'rubygems'
require 'parsers/atom'

handle = open('jobs.xml')
lines = handle.read
a = Splunk::Parsers::Atom
parsed = a.parse(lines)
puts parsed[0]['published']
puts parsed[1]['isDone']
puts parsed[2]['isDone']

h2 = open('job.xml')
l2 = h2.read
p2 = a.parse(l2)
puts p2[0]['published']
puts p2[0]['isDone']



