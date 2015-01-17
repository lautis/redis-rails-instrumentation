require 'spec_helper'
require 'redis'

class Redis
  module Rails
    describe Instrumentation do
      let(:redis) { Redis.new }
      let(:railtie) { Instrumentation::Railtie }

      after do
        if railtie.instance.send(:instance_variable_defined?, :@ran)
          railtie.instance.send(:remove_instance_variable, :@ran)
        end
      end

      it 'initializes a Railtie' do
        expect(railtie.superclass).to eq(::Rails::Railtie)
      end

      it 'logs runtimes' do
        Instrumentation::Railtie.run_initializers
        redis.get('test')
        expect(Instrumentation::LogSubscriber.runtime).to be > 0
      end

      it 'logs pipelined commands to a single line' do
        @logger.level = Logger::DEBUG
        Instrumentation::Railtie.run_initializers
        redis.pipelined do
          redis.get('test1')
          redis.get('test2')
        end
        expect(@logger.logged(:debug)[0])
          .to match(/Redis \(\d+\.\d+ms\)  \[ GET test1 \] \[ GET test2 \]/)
      end

      it 'logs commands to logger' do
        @logger.level = Logger::DEBUG
        Instrumentation::Railtie.run_initializers
        redis.get('test')
        expect(@logger.logged(:debug)[0])
          .to match(/Redis \(\d+\.\d+ms\)  \[ GET test \]/)
      end

      it 'omits debug logging in production' do
        @logger.level = Logger::ERROR
        Instrumentation::Railtie.run_initializers
        redis.get('test')
        expect(@logger.logged(:debug)).to be_empty
        expect(@logger.logged(:info)).to be_empty
        expect(@logger.logged(:error)).to be_empty
      end
    end
  end
end
