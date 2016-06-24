# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'mixtape'
set :deploy_user, 'deployer'
set :repo_url, 'git@github.com:freegyes/zeroswag-the-playlist.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '~/apps/mixtape_production'

# Default value for :scm is :git
set :scm, :git

set :pty, true

set :rbenv_type, :local
set :rbenv_ruby, '2.2.3'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# how many old releases do we want to keep
set :keep_releases, 5

# files we want symlinking to specific entries in shared.
set :linked_files, %w{config/database.yml config/application.yml config/secrets.yml}

# dirs we want symlinking to shared
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :tests, []

# which config files should be copied by deploy:setup_config
# see documentation in lib/capistrano/tasks/setup_config.cap
# for details of operations
set(:config_files, %w(
  nginx.conf
  database.example.yml
  log_rotation
  unicorn.rb
  unicorn_init.sh
))

# which config files should be made executable after copying
# by deploy:setup_config
set(:executable_config_files, %w(
  unicorn_init.sh
))

# files which need to be symlinked to other parts of the
# filesystem. For example nginx virtualhosts, log rotation
# init scripts etc.
set(
  :symlinks,
  [
    {
      source: "nginx.conf",
      link: "/etc/nginx/sites-enabled/{{full_app_name}}"
    },
    {
      source: "unicorn_init.sh",
      link: "/etc/init.d/unicorn_{{full_app_name}}"
    },
    {
      source: "log_rotation",
     link: "/etc/logrotate.d/{{full_app_name}}"
    }
  ]
)

set :assets_roles, [:app]

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
