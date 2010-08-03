require File.dirname(__FILE__) + '/spec_helper'

require 'dm-core/spec/adapter_shared_spec'

describe DataMapper::Adapters::SplunkAdapter do
  before :all do
    @adapter = DataMapper.setup(:default, :adapter   => 'splunk',
                                          :hostname  => 'localhost',
                                          :port      => 8000)
  end

  it_should_behave_like 'An Adapter'

end
