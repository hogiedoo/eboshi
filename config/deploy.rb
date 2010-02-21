set :application, "eboshi"
role :production, "www@botandrose.com"

namespace :data do
  namespace :pull do
    desc "Sync the public/files directory."
    task :assets, :roles => :production do
      system "rsync --delete -avz www@botandrose.com:#{application}/public/logos public/"
      system "rsync --delete -avz www@botandrose.com:#{application}/public/signatures public/"
    end
  end
end

after 'data:pull', 'data:pull:assets'
