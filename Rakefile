require './app'
require 'sinatra/activerecord/rake'
task :default => ["db"]
desc "Creates database"
task :db do
  sh "bundle"
  Rake::Task[:"db:environment:set"].invoke
  Rake::Task[:"db:schema:load"].invoke
  Rake::Task[:"db:seed"].invoke
end
task :serve do
  sh "rackup -p 4567"
end
task :deploy do
  Rake::Task[:"db"].invoke
  Rake::Task[:"serve"].invoke
end