# Capistrano::Puma

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano-puma', github: "seuros/capistrano-puma"

or:

    gem 'capistrano3-puma'

And then execute:

    $ bundle

## Usage
```ruby
    # Capfile

    require 'capistrano/puma'
    require 'capistrano/puma/jungle' #if you need the jungle tasks
```


Configurable options, shown here with defaults:
```ruby
    set :puma_state, "#{shared_path}/tmp/pids/puma.state"
    set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
    set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
    set :puma_conf, "#{shared_path}/puma.rb"
    set :puma_access_log, "#{shared_path}/log/puma_error.log"
    set :puma_error_log, "#{shared_path}/log/puma_access.log"
    set :puma_role, :app
    set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
    set :puma_threads, [0, 16]
    set :puma_workers, 0
```
For Jungle tasks (beta), these options exist:
```ruby
    set :puma_jungle_conf, '/etc/puma.conf'
    set :puma_run_path, '/usr/local/bin/run-puma'
```
Ensure that the following directories are shared (via ``linked_dirs``):

    tmp/pids tmp/sockets log

## Changelog

- 0.0.9: puma.rb location changed to shared_path root. puma:check moved to after deploy:check
- 0.0.8: puma.rb is automatically generated if not present. Fixed RVM issue.
- 0.0.7: Gem pushed to rubygems as capistrano3-puma. Support of Redhat based OS for Jungle init script.

## Contributors

[molfar](https://github.com/molfar)
[ayaya](https://github.com/ayamomiji)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
