module Capistrano
  module NginxPuma
    module Generators
      class ConfigGenerator < Rails::Generators::Base
        desc "Create local nginx and puma configuration files for customization"
        source_root File.expand_path('../templates', __FILE__)
        argument :templates_path, :type => :string,
          :default => "config/deploy/templates",
          :banner => "path to templates"

        def copy_template
          copy_file "../../../../capistrano/templates/puma.rb.erb", "#{templates_path}/puma.rb.erb"
          copy_file "../../../../capistrano/templates/nginx_conf.erb", "#{templates_path}/nginx_conf.erb"
          # copy_file "puma.rb.erb", "#{templates_path}/puma.rb.erb"
          # copy_file "puma_init.erb", "#{templates_path}/puma_init.erb"
          # copy_file "logrotate.erb", "#{templates_path}/logrotate.erb"
        end
      end
    end
  end
end
