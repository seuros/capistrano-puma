[![Gem Version](https://badge.fury.io/rb/capistrano3-puma.svg)](http://badge.fury.io/rb/capistrano3-puma)
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
    require 'capistrano/puma/workers' # if you want to control the workers (in cluster mode)
    require 'capistrano/puma/jungle'  # if you need the jungle tasks
    require 'capistrano/puma/monit'   # if you need the monit tasks
    require 'capistrano/puma/nginx'   # if you want to upload a nginx site template
```

then you can use ```cap -T``` to list tasks
```
cap puma:nginx_config # upload a nginx site config(eg. /etc/nginx/sites-enabled/)
cap puma:config  # upload puma config(eg. shared/puma.config)
```
you may want to customize these two templates locally before uploading
```
rails g capistrano:nginx_puma:config
```

if your nginx server configuration is not located in /etc/nginx, you may need to customize nginx_sites_available_path and nginx_sites_enabled_path
```
set :nginx_sites_available_path, "/etc/nginx/sites-available"
set :nginx_sites_enabled_path, "/etc/nginx/sites-enabled"
```

By default, ```nginx_config``` will be executed with ```:web``` role. But you can assign it to a different role:
```
set :puma_nginx, :foo
```
or define a standalone one:
```
role :puma_nginx, %w{root@example.com}
```

Configurable options, shown here with defaults: Please note the configuration options below are not required unless you are trying to override a default setting, for instance if you are deploying on a host on which you do not have sudo or root privileges and you need to restrict the path. These settings go in the deploy.rb file.

```ruby
    set :puma_user, fetch(:user)
    set :puma_rackup, -> { File.join(current_path, 'config.ru') }
    set :puma_state, "#{shared_path}/tmp/pids/puma.state"
    set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
    set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
    set :puma_default_control_app, "unix://#{shared_path}/tmp/sockets/pumactl.sock"
    set :puma_conf, "#{shared_path}/puma.rb"
    set :puma_access_log, "#{shared_path}/log/puma_access.log"
    set :puma_error_log, "#{shared_path}/log/puma_error.log"
    set :puma_role, :app
    set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
    set :puma_threads, [0, 16]
    set :puma_workers, 0
    set :puma_worker_timeout, nil
    set :puma_init_active_record, false
    set :puma_preload_app, false
    set :nginx_use_ssl, false
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

## Contributors

- [Ruohan Chen](https://github.com/crhan)
- [molfar](https://github.com/molfar)
- [ayaya](https://github.com/ayamomiji)
- [Shane O'Grady](https://github.com/shaneog)
- [Jun Lin](https://github.com/linjunpop)
- [fang duan](https://github.com/dfang)
- [Steve Madere](https://github.com/stevemadere)
- [Matias De Santi](https://github.com/mdesanti)
- [Huang Bin](https://github.com/hbin)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
