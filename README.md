# Capistrano::Puma

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano3-puma', github: "seuros/capistrano-puma"

or:

    gem 'capistrano3-puma'

And then execute:

    $ bundle

## Usage
```ruby
    # Capfile

    require 'capistrano/puma'
    require 'capistrano/puma/workers' #if you want to control the workers (in cluster mode)
    require 'capistrano/puma/jungle' #if you need the jungle tasks
    require 'capistrano/puma/monit' #if you need the monit tasks
```


Configurable options, shown here with defaults: Please note the configuration options below are not required unless you are trying to override a default setting, for instance if you are deploying on a host on which you do not have sudo or root privileges and you need to restrict the path. These settings go in the deploy.rb file. 

```ruby
    set :puma_rackup, -> { File.join(current_path, 'config.ru') }
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
    set :puma_init_active_record, false
    set :puma_preload_app, true
```
For Jungle tasks (beta), these options exist:
```ruby
    set :puma_jungle_conf, '/etc/puma.conf'
    set :puma_run_path, '/usr/local/bin/run-puma'
```
Ensure that the following directories are shared (via ``linked_dirs``):

    tmp/pids tmp/sockets log

## Changelog
- 0.3.5: Fixed a prehistoric bug
- 0.3.4: I don't remember what i did here
- 0.3.3: Puma jungle start fix
- 0.3.2: Tag option support (require puma  2.8.2+)
- 0.3.1: Typo fix
- 0.3.0: Initial support for puma signals
- 0.2.2: Application pre-loading is optional now (set puma_preload_app to false to turn it off)
- 0.2.1: Tasks are run within rack context
- 0.2.0: Support for puma `ActiveRecord::Base.establish_connection` on
  boot
- 0.1.3: Capistrano 3.1 support
- 0.1.2: Gemfile are refreshed between deploys now
- 0.1.1: Initial support for Monit and configuration override added.
- 0.1.0: Phased restart will be used if puma is in cluster mode
- 0.0.9: puma.rb location changed to shared_path root. puma:check moved to after deploy:check
- 0.0.8: puma.rb is automatically generated if not present. Fixed RVM issue.
- 0.0.7: Gem pushed to rubygems as capistrano3-puma. Support of Redhat based OS for Jungle init script.

## TODO

## Contributors

- [Ruohan Chen] (https://github.com/crhan)
- [molfar](https://github.com/molfar)
- [ayaya](https://github.com/ayamomiji)
- [Shane O'Grady](https://github.com/shaneog)


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
