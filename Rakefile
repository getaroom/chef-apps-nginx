require "bundler/setup"

task :default => :foodcritic

task :foodcritic do
  sh %{foodcritic . --epic-fail ~solo --epic-fail ~FC023}
end

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
rescue LoadError
  puts '>>>>> Kitchen gem not loaded, omitting tasks' unless ENV['CI']
end
