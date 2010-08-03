require 'rubygems'
require 'dm-core'

module Splunk
    module Model

        # == Usage
        #
        # Splunk::Job.new

        class Job
            include DataMapper::Resource

            URI = "/services/search/jobs"

            property :sid,      String, :key => true
            property :search,   String
            property :label,    String
            property :isDone,   String
            property :earliestTime, DateTime

        end
    end
end
