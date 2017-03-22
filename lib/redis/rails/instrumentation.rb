require 'redis'
require 'redis/rails/instrumentation/logging'
require 'redis/rails/instrumentation/version'
require 'active_support'
require 'sweet_notifications'

class Redis
  module Rails
    module Instrumentation
      Railtie, LogSubscriber = SweetNotifications.subscribe :redis,
                                                            label: 'Redis' do
        color ActiveSupport::LogSubscriber::RED

        event :command do |event|
          next unless logger.debug?
          cmds = event.payload[:commands]

          output = cmds.map do |name, *args|
            if !args.empty?
	      args = args.map { |arg| arg.respond_to?(:encoding) && arg.encoding == Encoding::ASCII_8BIT ? 'BINARY DATA' : arg }
              "[ #{name.to_s.upcase} #{args.join(' ')} ]"
            else
              "[ #{name.to_s.upcase} ]"
            end
          end.join(' ')

          debug message(event, 'Redis', output)
        end
      end
    end
  end
end

Redis::Client.send(:prepend, Redis::Rails::Instrumentation::Logging)
