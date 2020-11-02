git_plugin = self

namespace :puma do
  desc 'Setup Puma config file'
  task :config do
    on roles(fetch(:puma_role)) do |role|
      git_plugin.upload_puma_rb(role)
    end
  end

  task :check do
    on roles(fetch(:puma_role)) do |role|
      #Create puma.rb for new deployments
      unless  test "[ -f #{fetch(:puma_conf)} ]"
        warn 'puma.rb NOT FOUND!'
        git_plugin.upload_puma_rb(role)
        info 'puma.rb generated'
      end
    end
  end
end
