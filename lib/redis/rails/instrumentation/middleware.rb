class Redis
  module Rails
    module Middleware
      def connect(redis_config)
        ActiveSupport::Notifications.instrument("connect.redis") { super }
      end

      def call(command, redis_config)
        ActiveSupport::Notifications.instrument('command.redis', commands: [command]) do
            super
          end
      end

      def call_pipelined(commands, redis_config)
        ActiveSupport::Notifications.instrument('command.redis', commands: commands) do
            super
          end
      end
    end
  end
end
