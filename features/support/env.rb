require 'capybara'
require 'rspec'
require 'capybara/cucumber'

## Uncomment to enable SimpleCov
require 'simplecov'

SimpleCov.start do
  add_filter 'features/'
  add_filter 'db/'
end

## Replace with path to your controller
require_relative '../../app'

ENV['RACK_ENV'] = 'test'

Capybara.app = PiePiper
Capybara.ignore_hidden_elements = false

class Sinatra::ApplicationWorld
  include RSpec::Expectations
  include RSpec::Matchers
  include Capybara::DSL
end

World do
	Sinatra::ApplicationWorld.new
end
