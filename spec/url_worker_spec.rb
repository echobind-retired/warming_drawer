require 'helper'
require 'minitest/spec'
require 'minitest/autorun'
require 'warming_drawer'

describe WarmingDrawer::Workers::UrlWorker do

  describe 'with Sidekiq as a queuing system' do
    before do
      WarmingDrawer.configuration.queue_system = :sidekiq
    end

    it 'queues up http calls' do

    end
  end

  describe 'without a queuing system' do
    before do
      WarmingDrawer.configuration.queue_system = :inline
    end

    it 'makes the http calls directly'
  end

end