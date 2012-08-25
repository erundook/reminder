working_directory "/var/www/reminder"
pid "/var/www/reminder/tmp/pids/unicorn.pid"
stderr_path "/var/www/reminder/unicorn/unicorn.log"
stdout_path "/var/www/reminder/unicorn/unicorn.log"

listen "/tmp/unicorn.reminder.sock"
worker_processes 2
timeout 30

