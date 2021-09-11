require "bundler/gem_tasks"
require 'github_changelog_generator/task'

GitHubChangelogGenerator::RakeTask.new :changelog do |config|
  config.user = 'seuros'
  config.project = 'capistrano-puma'
  config.issues = false
  config.future_release = '5.2.0'
end
