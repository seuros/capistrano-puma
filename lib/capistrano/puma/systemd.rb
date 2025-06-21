module Capistrano
  class Puma::Systemd < Capistrano::Plugin
    include PumaCommon

    def register_hooks
      after 'deploy:finished', 'puma:smart_restart'
    end

    def define_tasks
      eval_rakefile File.expand_path('../../tasks/systemd.rake', __FILE__)
    end

    def set_defaults
      set_if_empty :puma_systemctl_bin, -> { fetch(:systemctl_bin, '/bin/systemctl') }
      set_if_empty :puma_service_unit_name, -> { "#{fetch(:application)}_puma_#{fetch(:stage)}" }
      set_if_empty :puma_enable_socket_service, false
      set_if_empty :puma_systemd_watchdog_sec, 10

      set_if_empty :puma_service_unit_env_files, -> { fetch(:service_unit_env_files, []) }
      set_if_empty :puma_service_unit_env_vars, -> { fetch(:service_unit_env_vars, []) }

      set_if_empty :puma_systemctl_user, -> { fetch(:systemctl_user, :user) }
      set_if_empty :puma_enable_lingering, -> { fetch(:puma_systemctl_user) != :system }
      set_if_empty :puma_lingering_user, -> { fetch(:lingering_user, fetch(:user)) }

      set_if_empty :puma_service_templates_path, fetch(:service_templates_path, 'config/deploy/templates')
    end

    def expanded_bundle_command
      backend.capture(:echo, SSHKit.config.command_map[:bundle]).strip
    end

    def fetch_systemd_unit_path
      if fetch(:puma_systemctl_user) == :system
        "/etc/systemd/system/"
      else
        home_dir = backend.capture :pwd
        File.join(home_dir, ".config", "systemd", "user")
      end
    end

    def systemd_command(*args)
      command = [fetch(:puma_systemctl_bin)]

      unless fetch(:puma_systemctl_user) == :system
        command << "--user"
      end

      command + args
    end

    def sudo_if_needed(*command)
      if fetch(:puma_systemctl_user) == :system
        backend.sudo command.map(&:to_s).join(" ")
      else
        backend.execute(*command)
      end
    end

    def execute_systemd(*args)
      sudo_if_needed(*systemd_command(*args))
    end
  end
end
