# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem 'haml'
  config.gem 'authlogic'
  config.gem "giraffesoft-resource_controller", :lib => "resource_controller", :source => "http://gems.github.com"
  config.gem 'paperclip', :version => '=2.1.2'
  config.gem 'RedCloth'
  config.gem 'ratom', :lib => "atom"
  config.gem "chriseppstein-compass", :version => ">=0.8.6", :lib => "compass", :source => "http://gems.github.com"
  config.gem 'chronic', :version => '>= 0.2.3'
  config.gem 'javan-whenever', :lib => false, :source => 'http://gems.github.com'

  config.action_controller.session = {
    :session_key => '_invoice_session',
    :secret      => 'dd8fca77ce51ddb3d42d1525ee8ebf6e084515596b0162a5db8b690c077641bb527be951d8945506fd9bacf300f886744857b26b4bb6c7c64fc0242e82594d9b'
  }

  config.time_zone = "Pacific Time (US & Canada)"

end

ExceptionNotifier.exception_recipients = %w(micah@botandrose.com)
