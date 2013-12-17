# Capistrano::Puma

How this gem works currently: 
```Currently this gem reads from the puma.rb file located in your shared directory. It will currently ignore any puma.rb files inside of staging specific folders or in the config directory. If it does not find a puma.rb file in the staging directory it will generate one. You must start puma initially with bundle exec cap $stage puma:start before a cap deploy will work, this is a bug which will be resolved shortly. The next version of this gem will support monit directly as well. 



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

The following options are only needed if you are working in a constrained environment. For instance on a machine on which you do not have root and you only have certain paths available to you. These settings are NOT needed on a regular installation think of them more as overrides. If you do have need of them put them in your deploy.rb

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

- 0.1.0: Phased restart will be used if puma is in cluster mode
- 0.0.9: puma.rb location changed to shared_path root. puma:check moved to after deploy:check
- 0.0.8: puma.rb is automatically generated if not present. Fixed RVM issue.
- 0.0.7: Gem pushed to rubygems as capistrano3-puma. Support of Redhat based OS for Jungle init script.

## Contributors

[molfar](https://github.com/molfar)
[ayaya](https://github.com/ayamomiji)
[Shane O'Grady](https://github.com/shaneog)


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
