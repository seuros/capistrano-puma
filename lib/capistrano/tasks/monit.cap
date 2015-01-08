namespace :load do
  task :defaults do
    set :puma_monit_conf_dir, -> { "/etc/monit/conf.d/#{puma_monit_service_name}.conf" }
    set :puma_monit_bin, -> { "/usr/bin/monit" }
  end
end


namespace :puma do
  namespace :monit do
    desc 'Config Puma monit-service'
    task :config do
      on roles(fetch(:puma_role)) do |role|
        @role = role
        template_puma 'puma_monit.conf', "#{fetch(:tmp_dir)}/monit.conf", @role
        sudo "mv #{fetch(:tmp_dir)}/monit.conf #{fetch(:puma_monit_conf_dir)}"
      end
    end

    desc 'Monitor Puma monit-service'
    task :monitor do
      on roles(fetch(:puma_role)) do
        sudo "#{fetch(:puma_monit_bin)} monitor #{puma_monit_service_name}"
      end
    end

    desc 'Unmonitor Puma monit-service'
    task :unmonitor do
      on roles(fetch(:puma_role)) do
        sudo "#{fetch(:puma_monit_bin)}  unmonitor #{puma_monit_service_name}"
      end
    end

    desc 'Start Puma monit-service'
    task :start do
      on roles(fetch(:puma_role)) do
        sudo "#{fetch(:puma_monit_bin)}  start #{puma_monit_service_name}"
      end
    end

    desc 'Stop Puma monit-service'
    task :stop do
      on roles(fetch(:puma_role)) do
        sudo "#{fetch(:puma_monit_bin)}  stop #{puma_monit_service_name}"
      end
    end

    desc 'Restart Puma monit-service'
    task :restart do
      on roles(fetch(:puma_role)) do
        sudo "#{fetch(:puma_monit_bin)}  restart #{puma_monit_service_name}"
      end
    end

    def puma_monit_service_name
      fetch(:puma_monit_service_name, "puma_#{fetch(:application)}_#{fetch(:stage)}")
    end

  end
end
