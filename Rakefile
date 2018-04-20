require './app'
require 'sinatra/activerecord/rake'
task :default => ["db"]
desc "Creates database"
task :db do
  Rake::Task[:"db:environment:set"].invoke
  Rake::Task[:"db:schema:load"].invoke
  Rake::Task[:"db:seed"].invoke
end