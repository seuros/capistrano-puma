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
      set_if_empty :puma_monit_wait_timeout, 120
    end

    def puma_monit_service_name
      fetch(:puma_monit_service_name, "puma_#{fetch(:application)}_#{fetch(:stage)}")
    end

    def sudo_if_needed(command)
      if fetch(:puma_monit_use_sudo)
        backend.sudo command
      else
        backend.execute command
      end
    end

    def wait_until_not_monitored
      backend.info "Wait until monit process is not monitored"
      cmd = "#{'sudo ' if fetch(:puma_monit_use_sudo)} #{fetch(:puma_monit_bin)} summary"

      start_time = Time.now
      loop do
        output = backend.capture(cmd)
        break if output !~ Regexp.new("^(.*#{puma_monit_service_name}.*)$")
        line = $1
        break if line =~ /Not monitored$/
        if start_time + fetch(:puma_monit_wait_timeout) < Time.now
          backend.warn 'Timeout... skip.'
          break
        end
        sleep 3
      end
    end
  end
end
