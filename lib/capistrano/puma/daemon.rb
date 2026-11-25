module Capistrano
  class Puma::Daemon < Capistrano::Plugin
    include PumaCommon

    def register_hooks
      after 'deploy:finished', 'puma:smart_restart'
    end

    def define_tasks
      eval_rakefile File.expand_path('../../tasks/daemon.rake', __FILE__)
    end
  end
end
