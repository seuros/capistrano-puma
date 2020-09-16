module Capistrano
  class Puma::Nginx < Capistrano::Plugin
    include PumaCommon
    def set_defaults
      # Nginx and puma configuration
      set_if_empty :nginx_config_name, -> { "#{fetch(:application)}_#{fetch(:stage)}" }
      set_if_empty :nginx_sites_available_path, '/etc/nginx/sites-available'
      set_if_empty :nginx_sites_enabled_path, '/etc/nginx/sites-enabled'
      set_if_empty :nginx_server_name,  -> { "localhost #{fetch(:application)}.local" }
      set_if_empty :nginx_flags, 'fail_timeout=0'
      set_if_empty :nginx_http_flags, fetch(:nginx_flags)
      set_if_empty :nginx_socket_flags, fetch(:nginx_flags)
      set_if_empty :nginx_use_ssl, false
      set_if_empty :nginx_use_http2, true
      set_if_empty :nginx_downstream_uses_ssl, false
    end

    def define_tasks
      eval_rakefile File.expand_path('../../tasks/nginx.rake', __FILE__)
    end
  end
end
