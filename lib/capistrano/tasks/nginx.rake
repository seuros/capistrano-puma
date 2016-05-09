namespace :load do
  task :defaults do
    # Nginx and puma configuration
    set :nginx_config_name, -> { "#{fetch(:application)}_#{fetch(:stage)}" }
    set :nginx_sites_available_path, -> { '/etc/nginx/sites-available' }
    set :nginx_sites_enabled_path, -> { '/etc/nginx/sites-enabled' }
    set :nginx_server_name, -> { "localhost #{fetch(:application)}.local" }
    set :nginx_flags, -> { 'fail_timeout=0' }
    set :nginx_http_flags, -> { fetch(:nginx_flags) }
    set :nginx_socket_flags, -> { fetch(:nginx_flags) }
    set :nginx_use_ssl, false
  end
end
namespace :puma do
  desc 'Setup nginx configuration'
  task :nginx_config do
    on roles(fetch(:puma_nginx, :web)) do |role|
      puma_switch_user(role) do
        template_puma('nginx_conf', "/tmp/nginx_#{fetch(:nginx_config_name)}", role)
        sudo :mv, "/tmp/nginx_#{fetch(:nginx_config_name)} #{fetch(:nginx_sites_available_path)}/#{fetch(:nginx_config_name)}"
        sudo :ln, '-fs', "#{fetch(:nginx_sites_available_path)}/#{fetch(:nginx_config_name)} #{fetch(:nginx_sites_enabled_path)}/#{fetch(:nginx_config_name)}"
      end
    end
  end
end
