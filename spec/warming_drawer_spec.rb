require 'helper'
require 'minitest/spec'
require 'minitest/autorun'
require 'warming_drawer'

describe WarmingDrawer do

  describe 'warm' do

    it 'takes any number of items to warm' do
      stub_request(:any, 'foo.com').to_return(:body => "good", :status => 200)
      stub_request(:any, 'yep.com').to_return(:body => "good", :status => 200)
      lambda {
        WarmingDrawer.warm 'http://foo.com'
        WarmingDrawer.warm 'http://foo.com', 'http://yep.com'
        WarmingDrawer.warm 'http://foo.com', :something => :else
      }.must_be_silent
    end
  end

  describe 'use_queue?' do
    it 'uses a queue if the queue_system is not inline' do
      WarmingDrawer.configure { |c| c.queue_system = :sidekiq }
      WarmingDrawer.use_queue?.must_equal true
    end

    it 'doesnt use a queue if the queue system is inline' do
      WarmingDrawer.configure { |c| c.queue_system = :inline }
      WarmingDrawer.use_queue?.must_equal false
    end
  end

  describe 'available_worker_for_type' do
    it 'returns a worker based on a type' do
      worker = WarmingDrawer.available_worker_for_type(:url)
      worker.must_be_kind_of Class
      worker.new.must_be_instance_of WarmingDrawer::Workers::UrlWorker
    end
  end

end