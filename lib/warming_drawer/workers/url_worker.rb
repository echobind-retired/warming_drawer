module WarmingDrawer
  module Workers
    class UrlWorker < BaseWorker
      require "net/http"
      require 'sidekiq'

      # for now since we assume Sidekiq, just add that in.
      include Sidekiq::Worker

      # params, urls
      def perform(*urls)
        urls.flatten.each do |url|
          uri = URI.parse url
          request = Net::HTTP::Get.new(uri.request_uri)
          config = WarmingDrawer.configuration

          if config.basic_auth_username && config.basic_auth_password
            request.basic_auth config.basic_auth_username, config.basic_auth_password
          end

          Net::HTTP.start(uri.hostname, uri.port) {|http|
            http.request(request)
          }
        end
      end

    end
  end
end