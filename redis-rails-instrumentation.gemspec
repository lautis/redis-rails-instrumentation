# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redis/rails/instrumentation/version'

Gem::Specification.new do |spec|
  spec.name          = 'redis-rails-instrumentation'
  spec.version       = Redis::Rails::Instrumentation::VERSION
  spec.authors       = ['Ville Lautanala']
  spec.email         = ['lautis@gmail.com']
  spec.summary       = 'Railtie to include Redis commands in Rails logging.'
  spec.description   = 'Log Redis commands and their total runtime in Rails request log.'
  spec.homepage      = 'https://github.com/lautis/redis-rails-instrumentation'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_dependency 'redis', '>= 3.0', '< 5'
  spec.add_dependency 'activesupport', '>= 3.0'
  spec.add_dependency 'sweet_notifications', '~> 1.0'
  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.required_ruby_version = '>= 2.0.0'
end
