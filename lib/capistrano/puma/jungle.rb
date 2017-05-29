module Capistrano
  class Puma::Jungle < Capistrano::Plugin
    include PumaCommon
    
    def set_defaults
      set_if_empty :puma_jungle_conf, '/etc/puma.conf'
      set_if_empty :puma_run_path, '/usr/local/bin/run-puma'
    end

    def define_tasks
      eval_rakefile File.expand_path('../../tasks/jungle.rake', __FILE__)
    end

    def debian_install(role)
      template_puma 'puma-deb', "#{fetch(:tmp_dir)}/puma", role
    end

    def rhel_install(role)
      template_puma 'puma-rpm', "#{fetch(:tmp_dir)}/puma", role
    end
  end
end
