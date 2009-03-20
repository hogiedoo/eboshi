# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
#require 'metric_fu'

#MetricFu::Configuration.run do |config|
#  config.churn = { :start_date => lambda{ 3.months.ago }, :minimum_churn_count => 3 }
#  config.saikuro = { "--warn_cyclo" => "3", "--error_cyclo" => "4" }
#end
	

require 'tasks/rails'
