source "http://rubygems.org"

gem "rails"
gem "bard-rake"
gem "mysql"
gem "ruby-debug", :group => [:development, :test, :cucumber]

gem "haml"
gem "compass"
gem "authlogic", :path => "vendor/gems/authlogic-2.1.6"
gem "paperclip"
gem "RedCloth", "4.2.2"
gem "ratom", "0.6.2", :require => "atom"
gem "chronic", "0.2.3"
gem "whenever", "0.3.7", :require => nil

group :test, :cucumber do
  gem "autotest-rails"
  gem "rspec-rails"
  gem "machinist", "1.0.6"
  gem "faker", "0.3.1"
  gem "webrat"

  gem "test-unit"
end

group :cucumber do
  gem "cucumber-rails"
  gem "database_cleaner"
  gem "capybara"
  gem "pickle"
  gem "nokogiri"
end
