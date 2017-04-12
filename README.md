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
    install_plugin Capistrano::Puma  # Default puma tasks
    install_plugin Capistrano::Puma::Workers  # if you want to control the workers (in cluster mode)
    install_plugin Capistrano::Puma::Jungle # if you need the jungle tasks
    install_plugin Capistrano::Puma::Monit  # if you need the monit tasks
    install_plugin Capistrano::Puma::Nginx  # if you want to upload a nginx site template
```

To prevent loading the hooks of the plugin, add false to the load_hooks param.
```ruby
    # Capfile

    require 'capistrano/puma'
    install_plugin Capistrano::Puma, load_hooks: false  # Default puma tasks without hooks
    install_plugin Capistrano::Puma::Monit, load_hooks: false  # Monit tasks without hooks
```

### Config

To list available tasks use `cap -T`

To upload puma config use:
```ruby
cap production puma:config
```
By default the file located in  `shared/puma.config`


Ensure that `tmp/pids` and ` tmp/sockets log` are shared (via `linked_dirs`):

`This step is mandatory before deploying, otherwise puma server won't start`

### Nginx

To upload a nginx site config (eg. /etc/nginx/sites-enabled/) use:
```ruby
cap production puma:nginx_config
```

To customize these two templates locally before uploading use:
```
rails g capistrano:nginx_puma:config
```

if your nginx server configuration is not located in `/etc/nginx`, you may need to customize:
```ruby
set :nginx_sites_available_path, "/etc/nginx/sites-available"
set :nginx_sites_enabled_path, "/etc/nginx/sites-enabled"
```

By default, `nginx_config` will be executed with `:web` role. But you can assign it to a different role:
```ruby
set :puma_nginx, :foo
```
or define a standalone one:
```ruby
role :puma_nginx, %w{root@example.com}
```

### Jungle

For Jungle tasks (beta), these options exist:
```ruby
    set :puma_jungle_conf, '/etc/puma.conf'
    set :puma_run_path, '/usr/local/bin/run-puma'
```

### Multi bind

Multi-bind can be set with an array in the puma_bind variable
```ruby
  set :puma_bind, %w(tcp://0.0.0.0:9292 unix:///tmp/puma.sock)
```
    * Listening on tcp://0.0.0.0:9220
    * Listening on unix:///tmp/puma.sock

### Active Record

For ActiveRecord the following line to your deploy.rb
```ruby
    set :puma_init_active_record, true
```

### Other configs

Configurable options, shown here with defaults: Please note the configuration options below are not required unless you are trying to override a default setting, for instance if you are deploying on a host on which you do not have sudo or root privileges and you need to restrict the path. These settings go in the deploy.rb file.

```ruby
    set :puma_user, fetch(:user)
    set :puma_rackup, -> { File.join(current_path, 'config.ru') }
    set :puma_state, "#{shared_path}/tmp/pids/puma.state"
    set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
    set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"    #accept array for multi-bind
    set :puma_control_app, false
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
    set :puma_daemonize, false
    set :puma_plugins, []  #accept array of plugins
    set :puma_tag, fetch(:application)

    set :nginx_config_name, "#{fetch(:application)}_#{fetch(:stage)}"
    set :nginx_flags, 'fail_timeout=0'
    set :nginx_http_flags, fetch(:nginx_flags)
    set :nginx_server_name, "localhost #{fetch(:application)}.local"
    set :nginx_sites_available_path, '/etc/nginx/sites-available'
    set :nginx_sites_enabled_path, '/etc/nginx/sites-enabled'
    set :nginx_socket_flags, fetch(:nginx_flags)
    set :nginx_ssl_certificate, "/etc/ssl/certs/{fetch(:nginx_config_name)}.crt"
    set :nginx_ssl_certificate_key, "/etc/ssl/private/{fetch(:nginx_config_name)}.key"
    set :nginx_use_ssl, false
```

__Notes:__ If you are setting values for variables that might be used by other plugins, use `append` instead of `set`. For example:
```ruby
append :rbenv_map_bins, 'puma', 'pumactl'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
