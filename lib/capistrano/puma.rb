require 'capistrano/bundler'
require 'capistrano/plugin'

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

    def compiled_template_puma(from, role)
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
      StringIO.new(ERB.new(erb, nil, '-').result(binding))
    end

    def template_puma(from, to, role)
      backend.upload! compiled_template_puma(from, role), to
    end

    PumaBind = Struct.new(:full_address, :kind, :address) do
      def unix?
        kind == :unix
      end

      def ssl?
        kind == :ssl
      end

      def tcp
        kind == :tcp || ssl?
      end

      def local
        if unix?
          self
        else
          PumaBind.new(
            localize_address(full_address),
            kind,
            localize_address(address)
          )
        end
      end

      private

      def localize_address(address)
        address.gsub(/0\.0\.0\.0(.+)/, "127.0.0.1\\1")
      end
    end

    def puma_binds
      Array(fetch(:puma_bind)).map do |m|
        etype, address  = /(tcp|unix|ssl):\/{1,2}(.+)/.match(m).captures
        PumaBind.new(m, etype.to_sym, address)
      end
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

      # Chruby, Rbenv and RVM integration
      append :chruby_map_bins, 'puma', 'pumactl'
      append :rbenv_map_bins, 'puma', 'pumactl'
      append :rvm_map_bins, 'puma', 'pumactl'

      # Bundler integration
      append :bundle_bins, 'puma', 'pumactl'
    end

    def register_hooks
      after 'deploy:check', 'puma:check'
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

require 'capistrano/puma/systemd'
require 'capistrano/puma/monit'
require 'capistrano/puma/nginx'
