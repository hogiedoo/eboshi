source "http://rubygems.org"

gem "rails"
gem "bard-rake"
gem "mysql"
gem "ruby-debug", :group => [:development, :test, :cucumber]

gem "haml"
gem "compass"
gem "authlogic", :path => "vendor/gems/authlogic-2.1.6"
gem "paperclip", :git => "git://github.com/lightyear/paperclip.git"
gem "RedCloth", "4.2.2"
gem "ratom", "0.6.2", :require => "atom"
gem "chronic", "0.2.3"
gem "whenever", "0.3.7", :require => nil
gem "exception_notification"
gem "limerick_rake"

group :test, :cucumber do
  gem "autotest-rails"
  gem "rspec-rails"
  gem "machinist", "1.0.6"
  gem "faker", "0.3.1"
  gem "webrat"
  gem "delorean"

  gem "test-unit"
end

group :cucumber do
  gem "cucumber-rails", :git => "git://github.com/botandrose/cucumber-rails.git"
  gem "database_cleaner"
  gem "capybara"
  gem "pickle"
  gem "nokogiri"
end
