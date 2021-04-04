# frozen_string_literal: true

git_plugin = self

namespace :puma do
  namespace :systemd do
    desc 'Config Puma systemd service'
    task :config do
      on roles(fetch(:puma_role)) do |role|
        unit_filename = "#{fetch(:puma_service_unit_name)}.service"
        git_plugin.template_puma "puma.service", "#{fetch(:tmp_dir)}/#{unit_filename}", role
        systemd_path = fetch(:puma_systemd_conf_dir, git_plugin.fetch_systemd_unit_path)
        if fetch(:puma_systemctl_user) == :system
          sudo "mv #{fetch(:tmp_dir)}/#{unit_filename} #{systemd_path}"
          sudo "#{fetch(:puma_systemctl_bin)} daemon-reload"
        else
          execute :mkdir, "-p", systemd_path
          execute :mv, "#{fetch(:tmp_dir)}/#{unit_filename}", "#{systemd_path}"
          execute fetch(:puma_systemctl_bin), "--user", "daemon-reload"
        end
      end
    end

    desc 'Generate service configuration locally'
    task :generate_config_locally do
      fake_role = Struct.new(:hostname)
      run_locally do
        File.write('puma.service', git_plugin.compiled_template_puma("puma.service", fake_role.new("example.com")).string)
        if fetch(:puma_enable_socket_service)
          File.write('puma.socket', git_plugin.compiled_template_puma("puma.socket", fake_role.new("example.com")).string)
        end
      end
    end

    desc 'Enable Puma systemd service'
    task :enable do
      on roles(fetch(:puma_role)) do
        if fetch(:puma_systemctl_user) == :system
          sudo "#{fetch(:puma_systemctl_bin)} enable #{fetch(:puma_service_unit_name)}"
        else
          execute "#{fetch(:puma_systemctl_bin)}", "--user", "enable", fetch(:puma_service_unit_name)
          execute :loginctl, "enable-linger", fetch(:puma_lingering_user) if fetch(:puma_enable_lingering)
        end
      end
    end

    desc 'Disable Puma systemd service'
    task :disable do
      on roles(fetch(:puma_role)) do
        if fetch(:puma_systemctl_user) == :system
          sudo "#{fetch(:puma_systemctl_bin)} disable #{fetch(:puma_service_unit_name)}"
        else
          execute "#{fetch(:puma_systemctl_bin)}", "--user", "disable", fetch(:puma_service_unit_name)
        end
      end
    end

  end

  desc 'Start Puma service via systemd'
  task :start do
    on roles(fetch(:puma_role)) do
      if fetch(:puma_systemctl_user) == :system
        sudo "#{fetch(:puma_systemctl_bin)} start #{fetch(:puma_service_unit_name)}"
      else
        execute "#{fetch(:puma_systemctl_bin)}", "--user", "start", fetch(:puma_service_unit_name)
      end
    end
  end

  desc 'Stop Puma service via systemd'
  task :stop do
    on roles(fetch(:puma_role)) do
      if fetch(:puma_systemctl_user) == :system
        sudo "#{fetch(:puma_systemctl_bin)} stop #{fetch(:puma_service_unit_name)}"
      else
        execute "#{fetch(:puma_systemctl_bin)}", "--user", "stop", fetch(:puma_service_unit_name)
      end
    end
  end

  desc 'Restart Puma service via systemd'
  task :restart do
    on roles(fetch(:puma_role)) do
      if fetch(:puma_systemctl_user) == :system
        sudo "#{fetch(:puma_systemctl_bin)} restart #{fetch(:puma_service_unit_name)}"
      else
        execute "#{fetch(:puma_systemctl_bin)}", "--user", "restart", fetch(:puma_service_unit_name)
      end
    end
  end

  desc 'Get Puma service status via systemd'
  task :status do
    on roles(fetch(:puma_role)) do
      if fetch(:puma_systemctl_user) == :system
        sudo "#{fetch(:puma_systemctl_bin)} status #{fetch(:puma_service_unit_name)}"
      else
        execute "#{fetch(:puma_systemctl_bin)}", "--user", "status", fetch(:puma_service_unit_name)
      end
    end
  end

  def fetch_systemd_unit_path
    if fetch(:puma_systemctl_user) == :system
      "/etc/systemd/system/"
    else
      home_dir = backend.capture :pwd
      File.join(home_dir, ".config", "systemd", "user")
    end
  end

end
