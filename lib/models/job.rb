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

      property :id, String, :key => true, :default => ''

      property :cursor_time,            DateTime, :field => 'cursorTime'
      property :delegate,               String
      property :done_progress,          Float, :field => 'doneProgress'
      property :drop_count,             Integer, :field => 'dropCount'
      property :earliest_time,          DateTime, :field => 'earliestTime'
      property :event_available_count,  Integer, :field => 'eventAvailableCount'
      property :event_count,            Integer, :field => 'eventCount'
      property :is_done,                Boolean, :field => 'isDone'
      property :is_failed,              Boolean, :field => 'isFailed'
      property :is_finalized,           Boolean, :field => 'isFinalized'
      property :is_paused,              Boolean, :field => 'isPaused'
      property :is_preview_enabled,     Boolean, :field => 'isPreviewEnabled'
      property :is_realtime_search,     Boolean, :field => 'isRealTimeSearch'
      property :ttl,                    Integer
      property :sid, String
      property :search, String
      property :label, String
      
      def update_from_create(wab)
        if wab[0].keys.include?('sid')
          attribute_set(:sid, wab[0]['sid'])
          attribute_set(:id, 'https://tui.splunk.com:8089/services/search/jobs/' + wab[0]['sid'])
        end
      end
      
      def key
        [id]
      end
    end
  end
end
