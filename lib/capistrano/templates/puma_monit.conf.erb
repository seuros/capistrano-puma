# Monit configuration for Puma
# Service name: <%= puma_monit_service_name %>
#
check process <%= puma_monit_service_name %>
  with pidfile "<%= fetch(:puma_pid) %>"
  start program = "/usr/bin/sudo -iu <%= puma_user(@role) %> /bin/bash -c 'cd <%= current_path %> && <%= SSHKit.config.command_map[:puma] %> -C <%= fetch(:puma_conf) %> --daemon'"
  stop program = "/usr/bin/sudo -iu <%= puma_user(@role) %> /bin/bash -c 'cd <%= current_path %> && <%= SSHKit.config.command_map[:pumactl] %> -S <%= fetch(:puma_state) %> stop'"
