require 'warming_drawer/configuration'
require 'warming_drawer/version'
require 'warming_drawer/workers/base_worker'
require 'warming_drawer/workers/url_worker'

module WarmingDrawer

  # Warms a cache. Delegates to the proper worker depending on the type.
  #
  # @example
  #   WarmingDrawer.warm('http://sweet.dev/1', 'http://sweet2.dev/2', :type => :url)
  def self.warm(*args)
    options = args.extract_options!
    options[:type] ||= :url

    if worker = available_worker_for_type(options[:type])
      worker.options queue: configuration.queue_name, retry: configuration.retry
      worker.perform_with(args)
    end
  end

  def self.use_queue?
    configuration.queue_system != :inline
  end

  def self.available_worker_for_type(type)
    worker_name = Workers.constants.detect {|c| c.downcase.match /^#{type.to_s.downcase}/}
    if worker_name
      WarmingDrawer::Workers.const_get worker_name.to_s
    end
  end

end
