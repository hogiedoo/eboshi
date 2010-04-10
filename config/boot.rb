# Don't change this file!
# Configure your app in config/environment.rb and config/environments/*.rb
require 'thread' # work with rubygems 1.5+

rescue LoadError
  # Otherwise, use RubyGems.
  require 'rubygems'

  # And set up the gems listed in the Gemfile.
  if File.exist?(File.expand_path('../../Gemfile', __FILE__))
    require 'bundler'
    Bundler.setup
  end
end
