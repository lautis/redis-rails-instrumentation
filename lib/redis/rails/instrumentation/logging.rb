class Redis
  module Rails
    module Instrumentation
      # Logging monkeypatch for Redis to emit ActiveSupport::Notification events
      module Logging
        def logging(commands, &block)
          ActiveSupport::Notifications.instrument('command.redis',
                                                  commands: commands) do
            return super(commands, &block)
          end
        end
      end
    end
  end
end
