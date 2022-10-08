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

To list available tasks use `cap -T`


Ensure that `tmp/pids` and ` tmp/sockets log` are shared (via `linked_dirs`):

`This step is mandatory before deploying, otherwise puma server won't start`

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
