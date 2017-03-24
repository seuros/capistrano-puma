git_plugin = self

namespace :puma do
  namespace :workers do
    desc 'Add a worker'
    task :count do
      on roles(fetch(:puma_role)) do |role|
        git_plugin.puma_switch_user(role) do
          #TODO
          # cleanup
          # add host name/ip
          puma_pid = capture("cat #{fetch(:puma_pid)}")
          workers_count = capture("ps ax | grep -c 'puma: cluster worker [0-9]: #{puma_pid}'").to_i
          log "Workers count : #{workers_count}"
        end
      end
    end

    # TODO
    # Add/remove workers to specific host/s
    # Define  # of workers to add/remove
    # Refactor
    desc 'Worker++'
    task :more do
      on roles(fetch(:puma_role)) do |role|
        git_plugin.puma_switch_user(role) do
          puma_pid = capture("cat  #{fetch(:puma_pid)}")
          execute(:kill, "-TTIN #{puma_pid}")
        end
      end
    end

    desc 'Worker--'
    task :less do
      on roles(fetch(:puma_role)) do |role|
        git_plugin.puma_switch_user(role) do
          puma_pid = capture("cat  #{fetch(:puma_pid)}")
          execute(:kill, "-TTOU #{puma_pid}")
        end
      end
    end
  end
end
