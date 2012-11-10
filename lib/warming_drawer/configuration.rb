module WarmingDrawer
  class Configuration
    attr_accessor :queue_name, :retry, :queue_system, :basic_auth_username, :basic_auth_password

    def initialize
      @queue_name = 'high'
      @retry      = false
      # TODO: would be nice to have values:
      #   :inline, :sidekiq, :resque, :delayed_job
      #   use Rails queue if defined
      @queue_system = :inline
    end

  end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end