root = '/var/www/fitncute/fitncute'
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/var/run/unicorn.todo.sock"

worker_processes 2
timeout 30