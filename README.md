# Redis Rails Instrumentation

Railtie to include Redis commands in Rails logging.

Version 2.0 and newer only supports redis-rb 5.x. If you need older version, please use 1.0.1.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'redis-rails-instrumentation'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install redis-rails-instrumentation

After you've started your Rails application, your Rails logs should include
Redis commands.

If you have debug logging enabled, individual commands are printed out:

      Redis (1.12ms)  [ GET test ]

A total runtime is also included per each request:

      Completed 200 OK in 1ms (Views: 0.2ms | ActiveRecord: 0.4ms | Redis: 1.12ms)

## Contributing

1. Fork it ( https://github.com/[my-github-username]/redis-rails-instrumentation/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
