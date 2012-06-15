set :application, "easy_blog"
set :repository,  "git clone ssh://root@183.90.188.96:10522/~/git/easy_blog.git"
set :use_sudo,false
set :deploy_to, '/var/www/projects/#{application}'
set :user, 'root'
set :password,'1qw23e'
set :scm, :git
ssh_options[:username] = 'root'
ssh_options[:port] = 2009
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "www.easy_blog.com"                          # Your HTTP server, Apache/etc
role :app, "www.easy_blog.com"                          # This may be the same as your `Web` server
role :db,  "www.easy_blog.com", :primary => true # This is where Rails migrations will run
role :db,  "www.easy_blog.com"

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
