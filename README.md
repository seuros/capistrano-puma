# Capistrano::Puma

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano3-puma', github: "seuros/capistrano-puma"

or:

    gem 'capistrano3-puma' , group: :development

And then execute:

    $ bundle

## Usage
```ruby
    # Capfile

    require 'capistrano/puma'
    require 'capistrano/puma/workers' #if you want to control the workers (in cluster mode)
    require 'capistrano/puma/jungle'  #if you need the jungle tasks
    require 'capistrano/puma/monit'   #if you need the monit tasks
    require 'capistrano/puma/nginx'   #if you want to upload a nginx site template
```

then you can use ```cap -vT``` to list tasks
```
cap nginx:config # upload a nginx site config(eg. /etc/nginx/site-enabled/)
cap puma:config  # upload puma config(eg. shared/puma.config)
```
you may want to customize these two templates localy before uploading
```
rails g capistrano:nginx_puma:config
```

if your nginx server configuration is not located in /etc/nginx, you may need to customize nginx_sites_available_path and nginx_sites_enabled_path
```
set :nginx_sites_available_path, "/etc/nginx/sites-available"
set :nginx_sites_enabled_path, "/etc/nginx/sites-enabled"
```

Configurable options, shown here with defaults: Please note the configuration options below are not required unless you are trying to override a default setting, for instance if you are deploying on a host on which you do not have sudo or root privileges and you need to restrict the path. These settings go in the deploy.rb file.

```ruby
    set :puma_rackup, -> { File.join(current_path, 'config.ru') }
    set :puma_state, "#{shared_path}/tmp/pids/puma.state"
    set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
    set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
    set :puma_conf, "#{shared_path}/puma.rb"
    set :puma_access_log, "#{shared_path}/log/puma_error.log"
    set :puma_error_log, "#{shared_path}/log/puma_access.log"
    set :puma_role, :app
    set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
    set :puma_threads, [0, 16]
    set :puma_workers, 0
    set :puma_worker_timeout, nil
    set :puma_init_active_record, false
    set :puma_preload_app, true
```
For Jungle tasks (beta), these options exist:
```ruby
    set :puma_jungle_conf, '/etc/puma.conf'
    set :puma_run_path, '/usr/local/bin/run-puma'
```

Multi-bind can be set with an array in the puma_bind variable
```ruby
  set :puma_bind, %w(tcp://0.0.0.0:9292 unix:///tmp/puma.sock)
```
    * Listening on tcp://0.0.0.0:9220
    * Listening on unix:///tmp/puma.sock


For ActiveRecord the following line to your deploy.rb
```ruby
    set :puma_init_active_record, true
```

Ensure that the following directories are shared (via ``linked_dirs``):

    tmp/pids tmp/sockets log

## Changelog
- 0.6.1: added :puma_default_hooks, you can turn off the automatic hooks by setting it false
- 0.6.0: Remove `daemonize true` from default puma.rb file. Explicitly pass `--daemon` flag when needed.
- 0.5.1: Added worker_timeout option
- 0.5.0: Bugs fixes
- 0.4.2: Fix monit template to support chruby
- 0.4.1: Fix puma jungle (debian)
- 0.4.0: Multi-bind support
- 0.3.7: Dependency bug fix
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

- [Ruohan Chen](https://github.com/crhan)
- [molfar](https://github.com/molfar)
- [ayaya](https://github.com/ayamomiji)
- [Shane O'Grady](https://github.com/shaneog)
- [Jun Lin](https://github.com/linjunpop)
- [fang duan](https://github.com/dfang/capistrano-puma)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
