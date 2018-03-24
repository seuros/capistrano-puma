git_plugin = self

namespace :puma do
  desc 'Setup nginx configuration'
  task :nginx_config do
    on roles(fetch(:puma_nginx, :web)) do |role|
      git_plugin.puma_switch_user(role) do
        git_plugin.template_puma('nginx_conf', "/tmp/nginx_#{fetch(:nginx_config_name)}", role)
        execute :mv, "/tmp/nginx_#{fetch(:nginx_config_name)} #{fetch(:nginx_sites_available_path)}/#{fetch(:nginx_config_name)}"
        execute :ln, '-fs', "#{fetch(:nginx_sites_available_path)}/#{fetch(:nginx_config_name)} #{fetch(:nginx_sites_enabled_path)}/#{fetch(:nginx_config_name)}"
      end
    end
  end
end
