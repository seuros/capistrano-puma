# frozen_string_literal: true

git_plugin = self

namespace :puma do
  namespace :systemd do
    desc 'Config Puma systemd service'
    task :config do
      on roles(fetch(:puma_role)) do |role|

        upload_compiled_template = lambda do |template_name, unit_filename|
          git_plugin.template_puma template_name, "#{fetch(:tmp_dir)}/#{unit_filename}", role
          systemd_path = fetch(:puma_systemd_conf_dir, git_plugin.fetch_systemd_unit_path)
          if fetch(:puma_systemctl_user) == :system
            sudo "mv #{fetch(:tmp_dir)}/#{unit_filename} #{systemd_path}"
          else
            execute :mkdir, "-p", systemd_path
            execute :mv, "#{fetch(:tmp_dir)}/#{unit_filename}", "#{systemd_path}"
          end
        end

        upload_compiled_template.call("puma.service", "#{fetch(:puma_service_unit_name)}.service")

        if fetch(:puma_enable_socket_service)
          upload_compiled_template.call("puma.socket", "#{fetch(:puma_service_unit_name)}.socket")
        end

        # Reload systemd
        git_plugin.execute_systemd("daemon-reload")
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
        git_plugin.execute_systemd("enable", fetch(:puma_service_unit_name))
        git_plugin.execute_systemd("enable", fetch(:puma_service_unit_name) + ".socket") if fetch(:puma_enable_socket_service)

        if fetch(:puma_systemctl_user) != :system && fetch(:puma_enable_lingering)
          execute :loginctl, "enable-linger", fetch(:puma_lingering_user)
        end
      end
    end

    desc 'Disable Puma systemd service'
    task :disable do
      on roles(fetch(:puma_role)) do
        git_plugin.execute_systemd("disable", fetch(:puma_service_unit_name))
        git_plugin.execute_systemd("disable", fetch(:puma_service_unit_name) + ".socket") if fetch(:puma_enable_socket_service)
      end
    end

    desc 'Stop Puma socket via systemd'
    task :stop_socket do
      on roles(fetch(:puma_role)) do
        git_plugin.execute_systemd("stop", fetch(:puma_service_unit_name) + ".socket")
      end
    end

    desc 'Restart Puma socket via systemd'
    task :restart_socket do
      on roles(fetch(:puma_role)) do
        git_plugin.execute_systemd("restart", fetch(:puma_service_unit_name) + ".socket")
      end
    end
  end

  desc 'Start Puma service via systemd'
  task :start do
    on roles(fetch(:puma_role)) do
      git_plugin.execute_systemd("start", fetch(:puma_service_unit_name))
    end
  end

  desc 'Stop Puma service via systemd'
  task :stop do
    on roles(fetch(:puma_role)) do
      git_plugin.execute_systemd("stop", fetch(:puma_service_unit_name))
    end
  end

  desc 'Restarts or reloads Puma service via systemd'
  task :smart_restart do
    if fetch(:puma_phased_restart)
      invoke 'puma:reload'
    else
      invoke 'puma:restart'
    end
  end

  desc 'Restart Puma service via systemd'
  task :restart do
    on roles(fetch(:puma_role)) do
      git_plugin.execute_systemd("restart", fetch(:puma_service_unit_name))
    end
  end

  desc 'Reload Puma service via systemd'
  task :reload do
    on roles(fetch(:puma_role)) do
      service_ok = if fetch(:puma_systemctl_user) == :system
        execute("#{fetch(:puma_systemctl_bin)} status #{fetch(:puma_service_unit_name)} > /dev/null", raise_on_non_zero_exit: false)
      else
        execute("#{fetch(:puma_systemctl_bin)} --user status #{fetch(:puma_service_unit_name)} > /dev/null", raise_on_non_zero_exit: false)
      end
      cmd = 'reload'
      if !service_ok
        cmd = 'restart'
      end
      if fetch(:puma_systemctl_user) == :system
        sudo "#{fetch(:puma_systemctl_bin)} #{cmd} #{fetch(:puma_service_unit_name)}"
      else
        execute "#{fetch(:puma_systemctl_bin)}", "--user", cmd, fetch(:puma_service_unit_name)
      end
    end
  end

  desc 'Get Puma service status via systemd'
  task :status do
    on roles(fetch(:puma_role)) do
      git_plugin.execute_systemd("status", fetch(:puma_service_unit_name))
      git_plugin.execute_systemd("status", fetch(:puma_service_unit_name) + ".socket") if fetch(:puma_enable_socket_service)
    end
  end
end
