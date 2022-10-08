### Nginx

#### Notes: 
This plugins is kept for quick prototyping. It is not recommended to use it in production.
Tools like ansible, puppet, chef, etc. are better suited for configuring your server.

To upload a nginx site config (eg. /etc/nginx/sites-enabled/) use:
```ruby
    # Capfile
    install_plugin Capistrano::Puma::Nginx
```
```shell
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

To use customize environment variables

```ruby
  set :puma_service_unit_env_files, '/etc/environment'
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

Other configs
```ruby
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
