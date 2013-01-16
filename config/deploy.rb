require 'bundler/capistrano'

set :application, 'bulletin_board'
set :repository,  'git://github.com/LasVegasRubyGroup/vegastech_app.git'

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

set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

role :web, '66.209.73.11'
role :app, '66.209.73.11'
role :db,  '66.209.73.11', primary: true

namespace :customs do
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/database.yml #{latest_release}/config/database.yml"
  end
end

require 'capistrano-unicorn'

after 'deploy:restart', 'deploy:cleanup'
after 'deploy:restart', 'unicorn:restart'
after 'deploy:update_code' do
  customs.symlink
end
