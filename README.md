[![Gem Version](https://badge.fury.io/rb/capistrano3-puma.svg)](http://badge.fury.io/rb/capistrano3-puma)
# Capistrano::Puma

Puma integration for Capistrano - providing systemd service management and zero-downtime deployments for Puma 5.1+.

## Example Application

For a complete working example of this gem in action, see the [capistrano-example-app](https://github.com/seuros/capistrano-example-app) which demonstrates:
- Rails 8.0 deployment with Capistrano
- Puma 6.0 with systemd socket activation
- Zero-downtime deployments
- rbenv integration
- Nginx configuration examples

## Installation

Add this line to your application's Gemfile:

    gem 'capistrano3-puma', github: "seuros/capistrano-puma"

or:

    gem 'capistrano3-puma' , group: :development

And then execute:

    $ bundle

## Upgrading from Version 5.x to 6.x

Version 6.0 includes several breaking changes:

### Breaking Changes:
1. **Manual Puma Configuration**: The gem no longer generates `puma.rb` automatically
   - You must create your own `config/puma.rb` in your repository
   - Add it to `linked_files` in your `deploy.rb`

2. **Default puma_bind Removed**: You must explicitly set the bind address
   ```ruby
   set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
   ```

3. **Systemd Service Changes**: Services are now user-specific by default
   - Services are created in `~/.config/systemd/user/`
   - Run `cap production puma:install` again after upgrading

### Migration Steps:
1. Create your `config/puma.rb` if you don't have one
2. Add to your `deploy.rb`:
   ```ruby
   append :linked_files, 'config/puma.rb'
   set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
   ```
3. Run `cap production puma:install` to update the systemd service
4. Deploy as normal

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

### First-Time Setup (IMPORTANT! 🎉)

**🙋 Hey there, human! Read this magical section and save yourself from confusion! 😊**

Before your first deployment, you MUST install the Puma systemd service on your server:

```bash
# ✨ This only needs to be done once per server/stage - it's like a first date! 💝
$ bundle exec cap production puma:install
```

This command will:
- 🏗️ Create the systemd service files for Puma
- 🚀 Enable the service to start on boot
- 🔐 Set up the proper user permissions

**🎭 Plot twist:** Without running this command first, your deployment will succeed but Puma won't start! (We know, it's sneaky like that 😅)

### Deployment

After the initial setup, normal deployments will work as expected:
```bash
$ bundle exec cap production deploy
```

The deployment process will automatically restart Puma using the installed systemd service.

To manually control the Puma service:
```bash
$ bundle exec cap production puma:start
$ bundle exec cap production puma:stop
$ bundle exec cap production puma:restart
```

To uninstall the systemd service:
```bash
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

## Troubleshooting

### Puma is not starting after deployment
- Ensure you ran `cap production puma:install` before your first deployment
- Check the service status: `cap production puma:status`
- Check logs: `sudo journalctl -u your_app_puma_production -n 100`

### Nginx 502 Bad Gateway errors
This usually means nginx and puma have mismatched configurations:
- If nginx expects a unix socket but puma binds to a port (or vice versa)
- Ensure your `puma_bind` in deploy.rb matches your nginx upstream configuration
- Common configurations:
  ```ruby
  # Unix socket (default)
  set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
  
  # TCP port
  set :puma_bind, "tcp://0.0.0.0:3000"
  ```

### Puma keeps restarting (systemd watchdog kills it)
- Your app may take longer than 10 seconds to boot
- Disable or increase WatchdogSec (requires version 6.0.0+):
  ```ruby
  set :puma_systemd_watchdog_sec, 30  # 30 seconds
  # or
  set :puma_systemd_watchdog_sec, 0   # Disable watchdog
  ```

# Nginx documentation
Nginx documentation was moved to [nginx.md](docs/nginx.md)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
