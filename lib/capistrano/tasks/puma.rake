namespace :load do
  task :defaults do
    set :puma_default_hooks, -> { true }
    set :puma_role, :app
    set :puma_env, -> { fetch(:rack_env, fetch(:rails_env, fetch(:stage))) }
    # Configure "min" to be the minimum number of threads to use to answer
    # requests and "max" the maximum.
    set :puma_threads, [0, 16]
    set :puma_workers, 0
    set :puma_rackup, -> { File.join(current_path, 'config.ru') }
    set :puma_state, -> { File.join(shared_path, 'tmp', 'pids', 'puma.state') }
    set :puma_pid, -> { File.join(shared_path, 'tmp', 'pids', 'puma.pid') }
    set :puma_bind, -> { File.join("unix://#{shared_path}", 'tmp', 'sockets', 'puma.sock') }
    set :puma_default_control_app, -> { File.join("unix://#{shared_path}", 'tmp', 'sockets', 'pumactl.sock') }
    set :puma_conf, -> { File.join(shared_path, 'puma.rb') }
    set :puma_access_log, -> { File.join(shared_path, 'log', 'puma_access.log') }
    set :puma_error_log, -> { File.join(shared_path, 'log', 'puma_error.log') }
    set :puma_init_active_record, false
    set :puma_preload_app, false

    # Chruby, Rbenv and RVM integration
    append :chruby_map_bins, 'puma', 'pumactl'
    append :rbenv_map_bins, 'puma', 'pumactl'
    append :rvm_map_bins, 'puma', 'pumactl'

    # Bundler integration
    append :bundle_bins, 'puma', 'pumactl'
  end
end

namespace :deploy do
  before :starting, :check_puma_hooks do
    invoke 'puma:add_default_hooks' if fetch(:puma_default_hooks)
  end
end

namespace :puma do

  desc 'Setup Puma config file'
  task :config do
    on roles(fetch(:puma_role)) do |role|
      template_puma 'puma', fetch(:puma_conf), role
    end
  end

  desc 'Start puma'
  task :start do
    on roles (fetch(:puma_role)) do |role|
      puma_switch_user(role) do
        if test "[ -f #{fetch(:puma_conf)} ]"
          info "using conf file #{fetch(:puma_conf)}"
        else
          invoke 'puma:config'
        end
        within current_path do
          with rack_env: fetch(:puma_env) do
            execute :bundle, 'exec', :puma, "-C #{fetch(:puma_conf)} --daemon"
          end
        end
      end
    end
  end

  %w[halt stop status].map do |command|
    desc "#{command} puma"
    task command do
      on roles (fetch(:puma_role)) do |role|
        within current_path do
          puma_switch_user(role) do
            with rack_env: fetch(:puma_env) do
              if test "[ -f #{fetch(:puma_pid)} ]"
                if test :kill, "-0 $( cat #{fetch(:puma_pid)} )"
                  execute :bundle, 'exec', :pumactl, "-S #{fetch(:puma_state)} -F #{fetch(:puma_conf)} #{command}"
                else
                  # delete invalid pid file , process is not running.
                  execute :rm, fetch(:puma_pid)
                end
              else
                #pid file not found, so puma is probably not running or it using another pidfile
                warn 'Puma not running'
              end
            end
          end
        end
      end
    end
  end

  %w[phased-restart restart].map do |command|
    desc "#{command} puma"
    task command do
      on roles (fetch(:puma_role)) do |role|
        within current_path do
          puma_switch_user(role) do
            with rack_env: fetch(:puma_env) do
              if test "[ -f #{fetch(:puma_pid)} ]" and test :kill, "-0 $( cat #{fetch(:puma_pid)} )"
                # NOTE pid exist but state file is nonsense, so ignore that case
                execute :bundle, 'exec', :pumactl, "-S #{fetch(:puma_state)} -F #{fetch(:puma_conf)} #{command}"
              else
                # Puma is not running or state file is not present : Run it
                invoke 'puma:start'
              end
            end
          end
        end
      end
    end
  end

  task :check do
    on roles (fetch(:puma_role)) do |role|
      #Create puma.rb for new deployments
      unless  test "[ -f #{fetch(:puma_conf)} ]"
        warn 'puma.rb NOT FOUND!'
        #TODO DRY
        template_puma 'puma', fetch(:puma_conf), role
        info 'puma.rb generated'
      end
    end
  end


  task :smart_restart do
    if !puma_preload_app? && puma_workers.to_i > 1
      invoke 'puma:phased-restart'
    else
      invoke 'puma:restart'
    end
  end

  def puma_switch_user(role, &block)
    user = puma_user(role)
    if user == role.user
      block.call
    else
      as user do
        block.call
      end
    end
  end

  def puma_user(role)
    properties = role.properties
    properties.fetch(:puma_user) ||               # local property for puma only
    fetch(:puma_user) ||
    properties.fetch(:run_as) || # global property across multiple capistrano gems
    role.user
  end

  def puma_workers
    fetch(:puma_workers, 0)
  end

  def puma_preload_app?
    fetch(:puma_preload_app)
  end

  def puma_bind
    Array(fetch(:puma_bind)).collect do |bind|
      "bind '#{bind}'"
    end.join("\n")
  end

  def puma_plugins
    Array(fetch(:puma_plugins)).collect do |bind|
      "plugin '#{bind}'"
    end.join("\n")
  end

  def template_puma(from, to, role)
    [
        "lib/capistrano/templates/#{from}-#{role.hostname}-#{fetch(:stage)}.rb",
        "lib/capistrano/templates/#{from}-#{role.hostname}.rb",
        "lib/capistrano/templates/#{from}-#{fetch(:stage)}.rb",
        "lib/capistrano/templates/#{from}.rb.erb",
        "lib/capistrano/templates/#{from}.rb",
        "lib/capistrano/templates/#{from}.erb",
        "config/deploy/templates/#{from}.rb.erb",
        "config/deploy/templates/#{from}.rb",
        "config/deploy/templates/#{from}.erb",
        File.expand_path("../../templates/#{from}.rb.erb", __FILE__),
        File.expand_path("../../templates/#{from}.erb", __FILE__)
    ].each do |path|
      if File.file?(path)
        erb = File.read(path)
        upload! StringIO.new(ERB.new(erb, nil, '-').result(binding)), to
        break
      end
    end
  end

  task :add_default_hooks do
    after 'deploy:check', 'puma:check'
    after 'deploy:finished', 'puma:smart_restart'
  end

end
