require './app'
require 'sinatra/activerecord/rake'
require 'rake/testtask'
require 'cucumber'
require 'cucumber/rake/task'
task :default => ["db"]
desc "Creates database"
task :db do
  sh "bundle"
  Rake::Task[:"db:environment:set"].invoke
  Rake::Task[:"db:schema:load"].invoke
  Rake::Task[:"db:seed"].invoke
end
task :serve do
  sh "rackup -p 4567 --host 0.0.0.0"
end
task :deploy do
  Rake::Task[:"db"].invoke
  Rake::Task[:"serve"].invoke
end
task :test do
  Rake::Task[:"db"].invoke
end
task :'test:features' do
  Rake::Task[:"db"].invoke
end
Rake::TestTask.new do |t|
  t.pattern = "test/*_test.rb"
end
Cucumber::Rake::Task.new(:'test:features') do |t|
  t.cucumber_opts = "features --format pretty"
end