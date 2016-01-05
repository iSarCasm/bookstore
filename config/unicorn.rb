# application root path
app_root = "/var/www/bookstore"

# Set the working application directory
# working_directory "/path/to/your/app"
working_directory app_root

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid "#{app_root}/shared/tmp/pids/unicorn.pid"

# Path to logs
# stderr_path "/path/to/log/unicorn.log"
# stdout_path "/path/to/log/unicorn.log"
stderr_path "#{app_root}/shared/log/unicorn.log"
stdout_path "#{app_root}/shared/log/unicorn.log"

# Unicorn socket
listen "/tmp/unicorn.[app name].sock"
listen "/tmp/unicorn.myapp.sock"

# Number of processes
# worker_processes 4
worker_processes 2

# Time-out
timeout 30
