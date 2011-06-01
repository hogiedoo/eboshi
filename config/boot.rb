# Don't change this file!
# Configure your app in config/environment.rb and config/environments/*.rb
require 'thread' # work with rubygems 1.5+

require 'rubygems'

# Set up gems listed in the Gemfile.
# Install dependencies if needed
`bundle check`
system "bundle install" if not $?.success?

gemfile = File.expand_path('../../Gemfile', __FILE__)
begin
  ENV['BUNDLE_GEMFILE'] = gemfile
  require 'bundler'
  Bundler.setup
rescue Bundler::GemNotFound => e
  STDERR.puts e.message
  STDERR.puts "Try running `bundle install`."
  exit!
end if File.exist?(gemfile)
