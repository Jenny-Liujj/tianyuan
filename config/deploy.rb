set :application, 'tianyuan'
set :rails_env, fetch(:stage)
set :scm, :git
set :repo_url, 'git@github.com:liu7899/tianyuan.git'
set :ssh_options, { keys: %w{~/.ssh/id_rsa}, forward_agent: true, auth_methods: %w(publickey) }
set :keep_releases, 5
set :format, :pretty
set :log_level, :info
set :deploy_to, '/var/www/tianyuan'
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :rbenv_ruby, '2.3.0'
set :rbenv_type, :user
set :default_env, { path: "/usr/local/rbenv/shims:/opt/rbenv/bin:$PATH" }
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all
set :linked_dirs, %w{log tmp public/uploads}
set :ssh_options, { forward_agent: true, port: 22 }

SSHKit.config.command_map[:rake]  = 'bundle exec rake'
SSHKit.config.command_map[:rails] = 'bundle exec rails'


namespace :db do
  desc 'Create database if not exist.'
  task :create do
    on roles(:db) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:create'
        end
      end
    end
  end
end
