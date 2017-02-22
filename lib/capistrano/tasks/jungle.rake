namespace :load do
  task :defaults do
    set :puma_jungle_conf, '/etc/puma.conf'
    set :puma_run_path, '/usr/local/bin/run-puma'
  end
end


namespace :puma do
  namespace :jungle do

    desc 'Install Puma jungle'
    task :install do
      on roles(fetch(:puma_role)) do |role|
        @role = role
        template_puma 'run-puma', "#{fetch(:tmp_dir)}/run-puma", role
        execute "chmod +x #{fetch(:tmp_dir)}/run-puma"
        sudo "mv #{fetch(:tmp_dir)}/run-puma #{fetch(:puma_run_path)}"
        if test '[ -f /etc/redhat-release ]'
          #RHEL flavor OS
          rhel_install
        elsif test '[ -f /etc/lsb-release ]'
          #Debian flavor OS
          debian_install
        else
          #Some other OS
          error 'This task is not supported for your OS'
        end
        sudo "touch #{fetch(:puma_jungle_conf)}"
      end
    end


    def debian_install
      template_puma 'puma-deb', "#{fetch(:tmp_dir)}/puma", @role
      execute "chmod +x #{fetch(:tmp_dir)}/puma"
      sudo "mv #{fetch(:tmp_dir)}/puma /etc/init.d/puma"
      sudo 'update-rc.d -f puma defaults'

    end

    def rhel_install
      template_puma 'puma-rpm', "#{fetch(:tmp_dir)}/puma" , @role
      execute "chmod +x #{fetch(:tmp_dir)}/puma"
      sudo "mv #{fetch(:tmp_dir)}/puma /etc/init.d/puma"
      sudo 'chkconfig --add puma'
    end


    desc 'Setup Puma config and install jungle script'
    task :setup do
      invoke 'puma:config'
      invoke 'puma:jungle:install'
      invoke 'puma:jungle:add'
    end

    desc 'Add current project to the jungle'
    task :add do
      on roles(fetch(:puma_role)) do|role|
        sudo "/etc/init.d/puma add '#{current_path}' #{fetch(:puma_user, role.user)}"
      end
    end

    desc 'Remove current project from the jungle'
    task :remove do
      on roles(fetch(:puma_role)) do
        sudo "/etc/init.d/puma remove '#{current_path}'"
      end
    end

    %w[start stop restart status].each do |command|
      desc "#{command} puma"
      task command do
        on roles(fetch(:puma_role)) do
          sudo "service puma #{command} app=#{current_path}"
        end
      end
    end

  end
end
