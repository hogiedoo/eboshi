require 'fileutils'
require 'pathname'

namespace :backup do
  desc "Backup the current database. Timestamped file is created as :rails_root/../db-name-timestamp.sql"
  task :db => :environment do 
    config    = ActiveRecord::Base.configurations[RAILS_ENV || 'development']
    filename  = "#{config['database'].gsub(/_/, '-')}-#{Time.now.strftime('%Y-%m-%d-%H-%M-%S')}.sql"
    backupdir = File.expand_path(File.join(Rails.root, '..'))
    filepath  = File.join(backupdir, filename)
    mysqldump = `which mysqldump`.strip
    options   =  "-e -u #{config['username']}"
    options   += " -p'#{config['password']}'" if config['password']
    options   += " -h #{config['host']}"      if config['host']

    raise RuntimeError, "I only work with mysql." unless config['adapter'].starts_with? 'mysql'
    raise RuntimeError, "Cannot find mysqldump." if mysqldump.blank?
    
    FileUtils.mkdir_p backupdir
    `#{mysqldump} #{options} #{config['database']} > #{filepath}`
    puts "#{config['database']} => #{filepath}"
  end


  desc "Backup all assets under public/system. File is created as :rails_root/../system.tgz"
  task :assets do 
    path       = (Pathname.new(Rails.root) + 'public' + 'system').realpath
    base_dir   = path.parent
    system_dir = path.basename
    outfile    = (Pathname.new(Rails.root) + '..').realpath + 'system.tgz'

    cd base_dir
    `tar -czf #{outfile} #{system_dir}`
    puts "Assets => #{outfile}"
  end
end

desc 'Backup the database and all assets by running the backup:db and backup:assets tasks.'
task :backup => ["backup:db", "backup:assets"]
