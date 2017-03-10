module Capistrano
  class Puma::Jungle < Capistrano::Plugin
    def set_defaults
      set_if_empty :puma_jungle_conf, '/etc/puma.conf'
      set_if_empty :puma_run_path, '/usr/local/bin/run-puma'
    end

    def define_tasks
      eval_rakefile File.expand_path('../../tasks/jungle.rake', __FILE__)
    end

    private

    def debian_install
      template_puma 'puma-deb', "#{fetch(:tmp_dir)}/puma", @role
      execute "chmod +x #{fetch(:tmp_dir)}/puma"
      sudo "mv #{fetch(:tmp_dir)}/puma /etc/init.d/puma"
      sudo 'update-rc.d -f puma defaults'
    end

    def rhel_install
      template_puma 'puma-rpm', "#{fetch(:tmp_dir)}/puma", @role
      execute "chmod +x #{fetch(:tmp_dir)}/puma"
      sudo "mv #{fetch(:tmp_dir)}/puma /etc/init.d/puma"
      sudo 'chkconfig --add puma'
    end
  end
end
