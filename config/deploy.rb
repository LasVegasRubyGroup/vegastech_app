
set :application, 'bulletin_board'
set :repository,  'git://github.com/LasVegasRubyGroup/vegastech_app.git'

set :scm, 'git'
set :scm_verbose, true
set :branch, 'master'
set :user, 'lvrug'
set :group, 'lvrug'
set :deploy_via, 'remote_cache'
set :deploy_to, "/home/#{user}/applications/#{application}"
set :use_sudo, false
set :init_script, "/etc/init.d/#{application}"

role :web, '66.209.73.11'
role :app, '66.209.73.11'
role :db,  '66.209.73.11', primary: true

require 'capistrano-unicorn'

after 'deploy:restart', 'deploy:cleanup'
after 'deploy:restart', 'unicorn:restart'

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
