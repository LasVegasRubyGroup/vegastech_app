require 'dotenv/capistrano'

load 'deploy/assets'

set :application, 'bulletin_board'
set :repository,  'git://github.com/LasVegasRubyGroup/vegastech_app.git'

set(:bundle_cmd) { 'bundle' }
set :bundle_flags, '--deployment --binstubs'
set :scm, 'git'
set :scm_verbose, true
set :branch, 'master'
set :user, 'lvrug'
set :group, 'lvrug'
set :deploy_via, 'remote_cache'
set :deploy_to, "/home/#{user}/applications/#{application}"
set :use_sudo, false
set :init_script, "/etc/init.d/#{application}"

set :sidekiq_cmd, "#{bundle_cmd} exec sidekiq"
set :sidekiqctl_cmd, "#{bundle_cmd} exec sidekiqctl"
set :sidekiq_timeout, 10
set :sidekiq_role, :app
set :sidekiq_pid, "#{current_path}/tmp/pids/sidekiq.pid"
set :sidekiq_processes, 3

require 'bundler/capistrano'
require 'capistrano-unicorn'

set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

role :web, 'news.lvrug.org'
role :app, 'news.lvrug.org'
role :db,  'news.lvrug.org', primary: true

namespace :customs do
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/database.yml #{latest_release}/config/database.yml"
  end
end

namespace :deploy do
  namespace :assets do
    task :precompile, roles: :web, except: { no_release: true } do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end

  namespace :sidekiq do
    desc 'Replace upstart config for sidekiq-workers'
    task :upstart_config do
      data = %Q{
        start on runlevel [2345]
        stop on runlevel [!2345]
        respawn

        exec su - #{user} -c 'cd #{release_path}; export RAILS_ENV=#{rails_env};  bundle exec sidekiq -q default,1 -c 4 -pid #{release_path}/tmp/pids/sidekiq.pid >> #{release_path}/log/sidekiq.log 2>&1'
      }
      source_path = release_path + '/config/bulletin-board-sidekiq-workers.conf'
      put data, source_path
      sudo "cp -f #{source_path} /etc/init/bulletin-board-sidekiq-workers.conf"
    end

    desc 'Restart sidekiq'
    task :restart do
      sudo "service bulletin-board-sidekiq-workers stop; /bin/true"
      sudo "service bulletin-board-sidekiq-workers start"
    end
  end

  namespace :stream do
    desc 'Replace upstart config for stream'
    task :upstart_config do
      data = %Q{
        start on runlevel [2345]
        stop on runlevel [!2345]
        respawn

        exec su - #{user} -c 'cd #{release_path}; source .env; export RAILS_ENV=#{rails_env}; export PORT=5100; ./script/stream >> #{release_path}/log/stream-1.log 2>&1'
      }
      source_path = release_path + '/config/bulletin-board-stream.conf'
      put data, source_path
      sudo "cp -f #{source_path} /etc/init/bulletin-board-stream.conf"
    end

    desc 'Restart stream'
    task :restart do
      sudo "service bulletin-board-stream stop; /bin/true"
      sudo "service bulletin-board-stream start"

    end
  end
end

require 'capistrano-unicorn'

after 'deploy:restart', 'unicorn:restart'  # app preloaded
after 'deploy:finalize_update', 'customs:symlink'
after 'deploy:finalize_update', 'deploy:sidekiq:upstart_config'
after 'deploy:finalize_update', 'deploy:stream:upstart_config'
after 'deploy:finalize_update', 'deploy:sidekiq:restart'
after 'deploy:finalize_update', 'deploy:stream:restart'
