module Capistrano
  class Puma::Systemd < Capistrano::Plugin
    include PumaCommon

    def register_hooks
      after 'deploy:finished', 'puma:restart'
    end

    def define_tasks
      eval_rakefile File.expand_path('../../tasks/systemd.rake', __FILE__)
    end

    def set_defaults
      set_if_empty :puma_systemd_conf_dir, '/etc/systemd/system'
      set_if_empty :puma_systemctl_bin, '/bin/systemctl'
      set_if_empty :puma_service_unit_name, -> { "puma_#{fetch(:application)}_#{fetch(:stage)}" }
    end
  end
end
