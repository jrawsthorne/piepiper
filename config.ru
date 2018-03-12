require './app'
require 'sprockets'
require 'uglifier'
require 'sass'


map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'public/style'
  environment.append_path 'public/scripts'
  environment.css_compressor = :scss
  environment.js_compressor  = :uglify
  run environment
end

map '/' do
  run PiePiper
end