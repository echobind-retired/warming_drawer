require 'warming_drawer/configuration'
require 'warming_drawer/version'
require 'warming_drawer/workers/base_worker'
require 'warming_drawer/workers/url_worker'

module WarmingDrawer

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  # Warms a cache. Delegates to the proper worker depending on the type.
  # If being used within Rails, returns false unless action_controller caching is enabled.
  #
  # @param [Array] args Arguments or Array to warm
  # @return [Boolean]
  # @example
  #   WarmingDrawer.warm('http://sweet.dev/1', 'http://sweet2.dev/2', :type => :url)
  #   => true
  def self.warm(*args)
    return false unless cachable?

    if args.last.is_a?(Hash)
      options = args.pop
    else
      options = {}
    end
    options[:type] ||= :url

    if worker = available_worker_for_type(options[:type])
      # TODO: can this move into worker since its reading config?
      worker.options queue: configuration.queue_name, retry: configuration.retry
      worker.perform_with(args)
    end

    !worker.nil?
  end

  # Returns true if a queuing system is defined
  # @return [Boolean]
  def self.use_queue?
    configuration.queue_system != :inline
  end


  private

    def self.cachable?
      (using_rails? && Rails.configuration.action_controller.perform_caching) || !using_rails?
    end

    def self.using_rails?
      defined?(::Rails)
    end

    def self.available_worker_for_type(type)
      if worker_name = Workers.constants.detect {|c| c.downcase.match /^#{type.to_s.downcase}/}
        WarmingDrawer::Workers.const_get worker_name.to_s
      end
    end

end
