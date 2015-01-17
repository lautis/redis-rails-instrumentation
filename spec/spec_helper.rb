require 'active_support/log_subscriber/test_helper'
require 'redis-rails-instrumentation'

RSpec.configure do |config|
  config.include ActiveSupport::LogSubscriber::TestHelper
  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.before do
    setup # Setup LogSubscriber::TestHelper
    allow(Redis::Rails::Instrumentation::LogSubscriber).to receive(:logger)
      .and_return(ActiveSupport::LogSubscriber::TestHelper::MockLogger.new)
  end

  config.after do
    teardown # Tear down LogSubscriber::TestHelper
  end
end
