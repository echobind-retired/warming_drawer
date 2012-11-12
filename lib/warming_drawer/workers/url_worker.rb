module WarmingDrawer
  module Workers
    class UrlWorker < BaseWorker
      require 'httpclient'
      require 'sidekiq'

      # for now since we assume Sidekiq, just add that in.
      include Sidekiq::Worker

      def perform(*urls)
        config = WarmingDrawer.configuration
        auth_present = config.basic_auth_username && config.basic_auth_password

        http = HTTPClient.new
        http.set_auth(nil, config.basic_auth_username, config.basic_auth_password)

        urls.flatten.each { |url| http.get url }
      end

    end
  end
end