module WarmingDrawer
  module Workers
    class BaseWorker

      class << self

        # Sets up perform with or without queue
        def perform_with(*args)
          if WarmingDrawer.use_queue?
            perform_with_queue(args)
          else
            perform_without_queue(args)
          end
        end

        def options(options_hash)
          # TODO: change this based on queuing system
          sidekiq_options options_hash
        end

        def perform_with_queue(*args)
          # TODO: change this based on queuing system
          perform_async(args)
        end

        def perform_without_queue(*args)
          new.perform(args)
        end

      end

      # Does the actual work
      def perform(*args)
        raise 'Override perform in your worker'
      end

    end
  end
end