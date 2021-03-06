# stages
set :stages, %w(staging production)
require 'capistrano/ext/multistage'

# General
set :application, 'doandose'
set :use_sudo, false
set :user, 'doandose'
role :app, 'doandose'
role :db,  'doandose', :primary => true

# repository
set :repository, 'git@codebasehq.com:voraz/personal/doandose.git'
set :scm, :git
set :deploy_via, :remote_cache
set :keep_releases, 10

# rvm
set :rvm_type, :system
require 'rvm/capistrano'

# ==
after 'deploy:update_code', 'assets:copy_config_files', 'assets:bundle', 'assets:compile'
after 'deploy', 'deploy:cleanup', "deploy:restart"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join current_path, 'tmp', 'restart.txt'}"
  end
end

namespace :assets do
  desc 'Create categories css and compile'
  task :compile, :roles => :app do
    run "cd #{release_path} && rake RAILS_ENV=#{rails_env} assets:precompile"
  end

  desc 'Copy config files like database.yml and .rvmrc'
  task :copy_config_files do
    run "cp #{release_path}/config/server/#{rails_env}/application.yml #{release_path}/config/application.yml"
    run "cp #{release_path}/config/server/#{rails_env}/mongoid.yml #{release_path}/config/mongoid.yml"
    run "cp #{release_path}/config/server/#{rails_env}/resque.yml #{release_path}/config/resque.yml"
    run "cp #{release_path}/config/server/#{rails_env}/rvmrc #{release_path}/.rvmrc"
  end

  task :bundle do
    run "cd #{release_path} && LC_ALL='en_US.UTF-8' RAILS_ENV='#{ rails_env }' bundle install --without test development"
  end
end