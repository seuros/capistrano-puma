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
You will need to select your service manager
```ruby
install_plugin Capistrano::Puma::Daemon  # If you using puma daemonized (not supported in Puma 5+)
```
or
```ruby
install_plugin Capistrano::Puma::Systemd  # if you use SystemD
```

To prevent loading the hooks of the plugin, add false to the load_hooks param.
```ruby
    # Capfile

    require 'capistrano/puma'
    install_plugin Capistrano::Puma, load_hooks: false  # Default puma tasks without hooks
    install_plugin Capistrano::Puma::Monit, load_hooks: false  # Monit tasks without hooks
```

To make it work with rvm, rbenv and chruby, install the plugin after corresponding library inclusion.
```ruby
    # Capfile

    require 'capistrano/rbenv'
    require 'capistrano/puma'
    install_plugin Capistrano::Puma
```

### Config

To list available tasks use `cap -T`

To upload puma config use:
```ruby
cap production puma:config
```
By default the file located in  `shared/puma.rb`


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

### Systemd

Install Systemd plugin in `Capfile`:
```ruby
install_plugin Capistrano::Puma
install_plugin Capistrano::Puma::Systemd
```

To generate unit file use:
```
cap production puma:systemd:config puma:systemd:enable
```

To use customize environment variables

```ruby
  set :puma_service_unit_env_file, '/etc/environment'
```
```ruby
  set :puma_service_unit_env_vars, %w[
      RAILS_ENV=development
      PUMA_METRICS_HTTP=tcp://0.0.0.0:9393
  ]
```

To use [phased restart](https://github.com/puma/puma/blob/master/docs/restart.md) for zero downtime deployments:

```ruby
  set :puma_phased_restart, true
```

### Systemd Socket Activation

Systemd socket activation starts your app upon first request if it is not already running

```ruby
    set :puma_enable_socket_service, true
```

For more information on socket activation have a look at the `systemd.socket` [man page](https://man7.org/linux/man-pages/man5/systemd.socket.5.html).

To restart the listening socket using Systemd run
```
cap puma:systemd:restart_socket
```
This would also restart the puma instance as the puma service depends on the socket service being active

### Multi bind

Multi-bind can be set with an array in the puma_bind variable
```ruby
  set :puma_bind, %w(tcp://0.0.0.0:9292 unix:///tmp/puma.sock)
```
    * Listening on tcp://0.0.0.0:9292
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
    set :puma_restart_command, 'bundle exec puma'
    set :puma_service_unit_name, "puma_#{fetch(:application)}_#{fetch(:stage)}"
    set :puma_systemctl_user, :system # accepts :user
    set :puma_enable_lingering, fetch(:puma_systemctl_user) != :system # https://wiki.archlinux.org/index.php/systemd/User#Automatic_start-up_of_systemd_user_instances
    set :puma_lingering_user, fetch(:user)
    set :puma_service_unit_env_file, nil
    set :puma_service_unit_env_vars, []
    set :puma_phased_restart, false

    set :nginx_config_name, "#{fetch(:application)}_#{fetch(:stage)}"
    set :nginx_flags, 'fail_timeout=0'
    set :nginx_http_flags, fetch(:nginx_flags)
    set :nginx_server_name, "localhost #{fetch(:application)}.local"
    set :nginx_sites_available_path, '/etc/nginx/sites-available'
    set :nginx_sites_enabled_path, '/etc/nginx/sites-enabled'
    set :nginx_socket_flags, fetch(:nginx_flags)
    set :nginx_ssl_certificate, "/etc/ssl/certs/#{fetch(:nginx_config_name)}.crt"
    set :nginx_ssl_certificate_key, "/etc/ssl/private/#{fetch(:nginx_config_name)}.key"
    set :nginx_use_ssl, false
    set :nginx_use_http2, true
    set :nginx_downstream_uses_ssl, false
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
