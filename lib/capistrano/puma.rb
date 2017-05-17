require 'capistrano/bundler'
require "capistrano/plugin"

module Capistrano
  module PumaCommon
    def puma_switch_user(role, &block)
      user = puma_user(role)
      if user == role.user
        block.call
      else
        backend.as user do
          block.call
        end
      end
    end

    def puma_user(role)
      properties = role.properties
      properties.fetch(:puma_user) || # local property for puma only
          fetch(:puma_user) ||
          properties.fetch(:run_as) || # global property across multiple capistrano gems
          role.user
    end

    def puma_bind
      Array(fetch(:puma_bind)).collect do |bind|
        "bind '#{bind}'"
      end.join("\n")
    end


    def template_puma(from, to, role)
      @role = role
      file = [
          "lib/capistrano/templates/#{from}-#{role.hostname}-#{fetch(:stage)}.rb",
          "lib/capistrano/templates/#{from}-#{role.hostname}.rb",
          "lib/capistrano/templates/#{from}-#{fetch(:stage)}.rb",
          "lib/capistrano/templates/#{from}.rb.erb",
          "lib/capistrano/templates/#{from}.rb",
          "lib/capistrano/templates/#{from}.erb",
          "config/deploy/templates/#{from}.rb.erb",
          "config/deploy/templates/#{from}.rb",
          "config/deploy/templates/#{from}.erb",
          File.expand_path("../templates/#{from}.erb", __FILE__),
          File.expand_path("../templates/#{from}.rb.erb", __FILE__)
      ].detect { |path| File.file?(path) }
      erb = File.read(file)
      backend.upload! StringIO.new(ERB.new(erb, nil, '-').result(binding)), to
    end
  end

  class Puma < Capistrano::Plugin
    include PumaCommon

    def define_tasks
      eval_rakefile File.expand_path('../tasks/puma.rake', __FILE__)
    end

    def set_defaults
      set_if_empty :puma_role, :app
      set_if_empty :puma_env, -> { fetch(:rack_env, fetch(:rails_env, fetch(:stage))) }
      # Configure "min" to be the minimum number of threads to use to answer
      # requests and "max" the maximum.
      set_if_empty :puma_threads, [0, 16]
      set_if_empty :puma_workers, 0
      set_if_empty :puma_rackup, -> { File.join(current_path, 'config.ru') }
      set_if_empty :puma_state, -> { File.join(shared_path, 'tmp', 'pids', 'puma.state') }
      set_if_empty :puma_pid, -> { File.join(shared_path, 'tmp', 'pids', 'puma.pid') }
      set_if_empty :puma_bind, -> { File.join("unix://#{shared_path}", 'tmp', 'sockets', 'puma.sock') }
      set_if_empty :puma_control_app, false
      set_if_empty :puma_default_control_app, -> { File.join("unix://#{shared_path}", 'tmp', 'sockets', 'pumactl.sock') }
      set_if_empty :puma_conf, -> { File.join(shared_path, 'puma.rb') }
      set_if_empty :puma_access_log, -> { File.join(shared_path, 'log', 'puma_access.log') }
      set_if_empty :puma_error_log, -> { File.join(shared_path, 'log', 'puma_error.log') }
      set_if_empty :puma_init_active_record, false
      set_if_empty :puma_preload_app, false
      set_if_empty :puma_daemonize, false
      set_if_empty :puma_tag, ''

      # Chruby, Rbenv and RVM integration
      append :chruby_map_bins, 'puma', 'pumactl'
      append :rbenv_map_bins, 'puma', 'pumactl'
      append :rvm_map_bins, 'puma', 'pumactl'

      # Bundler integration
      append :bundle_bins, 'puma', 'pumactl'
    end

    def register_hooks
      after 'deploy:check', 'puma:check'
      after 'deploy:finished', 'puma:smart_restart'
    end

    def puma_workers
      fetch(:puma_workers, 0)
    end

    def puma_preload_app?
      fetch(:puma_preload_app)
    end

    def puma_daemonize?
      fetch(:puma_daemonize)
    end

    def puma_plugins
      Array(fetch(:puma_plugins)).collect do |bind|
        "plugin '#{bind}'"
      end.join("\n")
    end

    def upload_puma_rb(role)
      template_puma 'puma', fetch(:puma_conf), role
    end
  end
end

require 'capistrano/puma/workers'
require 'capistrano/puma/monit'
require 'capistrano/puma/jungle'
require 'capistrano/puma/nginx'
