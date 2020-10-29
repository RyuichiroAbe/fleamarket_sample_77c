lock '3.14.1'

set :application, 'fleamarket_sample_77c'
set :repo_url, 'git@github.com:ryutaro-hirasawa/fleamarket_sample_77c.git'

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.5.1'

set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/fleamarket.pem']

set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

set :linked_files, %w[config/master.key]

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:stop'
    invoke 'unicorn:start'
  end

  # desc 'upload master.key'
  # task :upload do
  #   on roles(:app) do |_host|
  #     execute "mkdir -p #{shared_path}/config" if test "[ ! -d #{shared_path}/config ]"
  #     upload!('config/master.key', "#{shared_path}/config/master.key")
  #   end
  # end
  # before :starting, 'deploy:upload'
  # after :finishing, 'deploy:cleanup'
end
