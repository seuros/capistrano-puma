module Capistrano
  class Puma::Monit < Capistrano::Plugin
    include PumaCommon
    def register_hooks
      before 'deploy:updating', 'puma:monit:unmonitor'
      after 'deploy:published', 'puma:monit:monitor'
    end

    def define_tasks
      eval_rakefile File.expand_path('../../tasks/monit.rake', __FILE__)
    end

    def set_defaults
      set_if_empty :puma_monit_conf_dir, -> { "/etc/monit/conf.d/#{puma_monit_service_name}.conf" }
      set_if_empty :puma_monit_use_sudo, true
      set_if_empty :puma_monit_bin, '/usr/bin/monit'
    end

    def puma_monit_service_name
      fetch(:puma_monit_service_name, "puma_#{fetch(:application)}_#{fetch(:stage)}")
    end

    def sudo_if_needed(command)
      if fetch(:puma_monit_use_sudo)
        backend.sudo command
      else
        puma_role = fetch(:puma_role)
        backend.on(puma_role) do
          backend.execute command
        end
      end
    end
  end
end
