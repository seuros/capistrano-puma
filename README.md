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
    install_plugin Capistrano::Puma::Systemd
```

To prevent loading the hooks of the plugin, add false to the load_hooks param.
```ruby
    # Capfile

    install_plugin Capistrano::Puma, load_hooks: false  # Default puma tasks without hooks
```

To make it work with rvm, rbenv and chruby, install the plugin after corresponding library inclusion.
```ruby
    # Capfile

    require 'capistrano/rbenv'
    require 'capistrano/puma'
    install_plugin Capistrano::Puma
```

### Config

Puma configuration is expected to be in `config/puma.rb` or `config/puma/#{fetch(:puma_env)}.rb` and checked in your repository.

Starting with version 6.0.0, you need to manage the puma configuration file yourself. Here are the steps:

1. Create your puma configuration in `shared/config/puma.rb` on the server
2. Add it to linked_files in your `deploy.rb`:
   ```ruby
   append :linked_files, 'config/puma.rb'
   ```

This ensures the puma configuration persists across deployments. The systemd service will start puma with `puma -e <environment>` from your app's current directory.

### Deployment

Before running `$ bundle exec cap {stage} deploy` for the first time, install Puma on the deployment server. For example, if stage=production:
```
$ bundle exec cap production puma:install
```

To uninstall,
```
$ bundle exec cap production puma:uninstall
```

### Full Task List
```
$ cap -T puma
cap puma:disable         # Disable Puma systemd service
cap puma:enable          # Enable Puma systemd service
cap puma:install         # Install Puma systemd service
cap puma:reload          # Reload Puma service via systemd
cap puma:restart         # Restart Puma service via systemd
cap puma:restart_socket  # Restart Puma socket via systemd
cap puma:smart_restart   # Restarts or reloads Puma service via systemd
cap puma:start           # Start Puma service via systemd
cap puma:status          # Get Puma service status via systemd
cap puma:stop            # Stop Puma service via systemd
cap puma:stop_socket     # Stop Puma socket via systemd
cap puma:uninstall       # Uninstall Puma systemd service
```
## Example

A sample application is provided to show how to use this gem at https://github.com/seuros/capistrano-example-app

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

### Other configs

Configurable options, shown here with defaults: Please note the configuration options below are not required unless you are trying to override a default setting, for instance if you are deploying on a host on which you do not have sudo or root privileges and you need to restrict the path. These settings go in the deploy.rb file.

```ruby
    set :puma_user, fetch(:user)
    set :puma_role, :web
    set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
    set :puma_systemd_watchdog_sec, 10  # Set to 0 or false to disable watchdog
    set :puma_service_unit_env_files, []
    set :puma_service_unit_env_vars, []
```

__Notes:__ If you are setting values for variables that might be used by other plugins, use `append` instead of `set`. For example:
```ruby
append :rbenv_map_bins, 'puma', 'pumactl'
```

# Nginx documentation
Nginx documentation was moved to [nginx.md](docs/nginx.md)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
