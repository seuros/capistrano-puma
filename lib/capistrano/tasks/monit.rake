git_plugin = self

namespace :puma do
  namespace :monit do
    desc 'Config Puma monit-service'
    task :config do
      on roles(fetch(:puma_role)) do |role|
        @role = role
        git_plugin.template_puma 'puma_monit.conf', "#{fetch(:tmp_dir)}/monit.conf", @role
        sudo_if_needed "mv #{fetch(:tmp_dir)}/monit.conf #{fetch(:puma_monit_conf_dir)}"
        sudo_if_needed "#{fetch(:puma_monit_bin)} reload"
      end
    end

    desc 'Monitor Puma monit-service'
    task :monitor do
      on roles(fetch(:puma_role)) do
        begin
          sudo_if_needed "#{fetch(:puma_monit_bin)} monitor #{puma_monit_service_name}"
        rescue
          invoke 'puma:monit:config'
          sudo_if_needed "#{fetch(:puma_monit_bin)} monitor #{puma_monit_service_name}"
        end
      end
    end

    desc 'Unmonitor Puma monit-service'
    task :unmonitor do
      on roles(fetch(:puma_role)) do
        begin
          sudo_if_needed "#{fetch(:puma_monit_bin)} unmonitor #{puma_monit_service_name}"
        rescue
          # no worries here (still no monitoring)
        end
      end
    end

    desc 'Start Puma monit-service'
    task :start do
      on roles(fetch(:puma_role)) do
        sudo_if_needed "#{fetch(:puma_monit_bin)} start #{puma_monit_service_name}"
      end
    end

    desc 'Stop Puma monit-service'
    task :stop do
      on roles(fetch(:puma_role)) do
        sudo_if_needed "#{fetch(:puma_monit_bin)}  stop #{puma_monit_service_name}"
      end
    end

    desc 'Restart Puma monit-service'
    task :restart do
      on roles(fetch(:puma_role)) do
        sudo_if_needed "#{fetch(:puma_monit_bin)} restart #{puma_monit_service_name}"
      end
    end

  end
end