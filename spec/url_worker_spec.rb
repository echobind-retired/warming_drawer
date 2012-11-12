require 'helper'
require 'minitest/spec'
require 'minitest/autorun'
require 'warming_drawer'

describe WarmingDrawer::Workers::UrlWorker do

  describe 'with Sidekiq as a queuing system' do
    before do
      WarmingDrawer.configure do |config|
        config.queue_system = :sidekiq
      end
    end

    it 'queues up http calls'
  end

  describe 'without a queuing system' do
    before do
      WarmingDrawer.configure do |config|
        config.queue_system = :sidekiq
      end
    end

    it 'makes the http calls directly'
  end

end