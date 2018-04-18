require './app'
require 'sprockets'
require 'uglifier'
require 'sass'

# serve static files if URL is /assets
map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'public/style'
  environment.append_path 'public/scripts'
  # compile sass to css
  environment.css_compressor = :scss
  # minify javascript
  environment.js_compressor  = :uglify
  run environment
end

# serve the main app at any other URL
map '/' do
  run PiePiper
end