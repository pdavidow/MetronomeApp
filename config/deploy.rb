lock '~> 3.11.0'

set :application, 'mentronome'
set :repo_url, 'git@github.com:pdavidow/MetronomeApp.git'
set :deploy_to, '/home/ubuntu/mentronome'
set :stage, :production
set :user, 'ubuntu'
set :pty, true
set :use_sudo, false
set :deploy_via, :remote_cache

set :linked_files, %w[config/secrets.yml]
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system]

set :branch, 'master'
set :ssh_options, forward_agent: true, user: fetch(:user), keys: %w[~/.ssh/metronome.pem]

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
  after :finishing, 'deploy:update_cron'
end

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end
