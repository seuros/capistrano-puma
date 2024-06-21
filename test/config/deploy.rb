lock "~> 3.19.1"

set :application, "capistrano-puma"
set :repo_url, "https://github.com/seuros/capistrano-puma.git"
set :repo_tree, 'test/app'

set :branch, ENV['BRANCH'] || 'master'

# Without the following settings, puma will fail to start.
append :linked_dirs, "log"
