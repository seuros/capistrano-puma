git_plugin = self

namespace :puma do
  desc 'Setup Puma config file'
  task :config do
    on roles(fetch(:puma_role)) do |role|
      git_plugin.upload_puma_rb(role)
    end
  end

  desc 'Start puma'
  task :start do
    on roles(fetch(:puma_role)) do |role|
      git_plugin.puma_switch_user(role) do
        if test "[ -f #{fetch(:puma_conf)} ]"
          info "using conf file #{fetch(:puma_conf)}"
        else
          invoke 'puma:config'
        end

        if test "[ -f #{fetch(:puma_pid)} ]" and test :kill, "-0 $( cat #{fetch(:puma_pid)} )"
          info 'Already Puma is running'
        else
          within current_path do
            with rack_env: fetch(:puma_env) do
              execute :puma, "-C #{fetch(:puma_conf)} --daemon"
            end
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
          git_plugin.puma_switch_user(role) do
            with rack_env: fetch(:puma_env) do
              if test "[ -f #{fetch(:puma_pid)} ]"
                if test :kill, "-0 $( cat #{fetch(:puma_pid)} )"
                  execute :pumactl, "-S #{fetch(:puma_state)} -F #{fetch(:puma_conf)} #{command}"
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
          git_plugin.puma_switch_user(role) do
            with rack_env: fetch(:puma_env) do
              if test "[ -f #{fetch(:puma_pid)} ]" and test :kill, "-0 $( cat #{fetch(:puma_pid)} )"
                # NOTE pid exist but state file is nonsense, so ignore that case
                execute :pumactl, "-S #{fetch(:puma_state)} -F #{fetch(:puma_conf)} #{command}"
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
    on roles(fetch(:puma_role)) do |role|
      #Create puma.rb for new deployments
      unless  test "[ -f #{fetch(:puma_conf)} ]"
        warn 'puma.rb NOT FOUND!'
        git_plugin.upload_puma_rb(role)
        info 'puma.rb generated'
      end
    end
  end


  task :smart_restart do
    if !git_plugin.puma_preload_app? && git_plugin.puma_workers.to_i > 1
      invoke 'puma:phased-restart'
    else
      invoke 'puma:restart'
    end
  end

end
