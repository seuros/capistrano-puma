# frozen_string_literal: true

git_plugin = self

namespace :puma do
  namespace :systemd do
    desc 'Config Puma systemd service'
    task :config do
      on roles(fetch(:puma_role)) do |role|
        unit_filename = "#{fetch(:puma_service_unit_name)}.service"
        git_plugin.template_puma "puma.service", "#{fetch(:tmp_dir)}/#{unit_filename}", role
        sudo "mv #{fetch(:tmp_dir)}/#{unit_filename} #{fetch(:puma_systemd_conf_dir)}"
        sudo "#{fetch(:puma_systemctl_bin)} daemon-reload"
      end
    end

    desc 'Enable Puma systemd service'
    task :enable do
      on roles(fetch(:puma_role)) do
        sudo "#{fetch(:puma_systemctl_bin)} enable #{fetch(:puma_service_unit_name)}"
      end
    end

    desc 'Disable Puma systemd service'
    task :disable do
      on roles(fetch(:puma_role)) do
        sudo "#{fetch(:puma_systemctl_bin)} disable #{fetch(:puma_service_unit_name)}"
      end
    end
  end

  desc 'Start Puma service via systemd'
  task :start do
    on roles(fetch(:puma_role)) do
      sudo "#{fetch(:puma_systemctl_bin)} start #{fetch(:puma_service_unit_name)}"
    end
  end

  desc 'Stop Puma service via systemd'
  task :stop do
    on roles(fetch(:puma_role)) do
      sudo "#{fetch(:puma_systemctl_bin)} stop #{fetch(:puma_service_unit_name)}"
    end
  end

  desc 'Restart Puma service via systemd'
  task :restart do
    on roles(fetch(:puma_role)) do
      sudo "#{fetch(:puma_systemctl_bin)} restart #{fetch(:puma_service_unit_name)}"
    end
  end

  desc 'Get Puma service status via systemd'
  task :status do
    on roles(fetch(:puma_role)) do
      sudo "#{fetch(:puma_systemctl_bin)} status #{fetch(:puma_service_unit_name)}"
    end
  end
end
