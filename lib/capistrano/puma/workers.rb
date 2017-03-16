module Capistrano
  class Puma::Workers < Capistrano::Plugin
    def define_tasks
      eval_rakefile File.expand_path('../../tasks/workers.rake', __FILE__)
    end
  end
end