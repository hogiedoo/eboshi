require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'factory_girl'
require 'faker'

Factory.define :client do |c|
  c.name { Faker::Company.name }
  c.address { Faker::Address.street_address }
  c.city { Faker::Address.city }
  c.state { Faker::Address.us_state }
  c.zip { Faker::Address.zip_code }
  c.country { Faker::Address.uk_country }
  c.email { Faker::Internet.email }
  c.contact { Faker::Name.name }
  c.phone { Faker::PhoneNumber.phone_number }
end

Factory.define :user do |u|
  u.login { Faker::Name.name.gsub(/[^a-zA-Z]/, '') }
  u.email { Faker::Internet.email }
  u.password "insecure"
  u.password_confirmation "insecure"
  u.created_at Time.today
  u.updated_at Time.today
  u.rate 50
  u.color '123456'
end

Factory.define :work do |w|
  w.client { Factory :client }
  w.invoice { Factory :invoice }
  w.user { Factory :user }
  w.start Time.today
  w.finish Time.today + 1.hour
  w.rate 50
  w.notes { Faker::Lorem.sentence rand(3) }
end

Factory.define :adjustment do |a|
  a.client { Factory :client }
  a.invoice { Factory :invoice }
  a.user { Factory :user }
  a.rate 0
  a.notes "adjustment"
end

Factory.define :invoice do |i|
  i.client { Factory :client }
  i.date Date.today
  i.project_name { Faker::Company.name }
end
