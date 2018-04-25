ENV['RACK_ENV'] = 'test'

require_relative '../app'

require 'minitest/autorun'
require 'rack/test'