require 'machinist'
require 'faker'

Client.blueprint do
  name { Faker::Company.name }
  address { Faker::Address.street_address }
  city { Faker::Address.city }
  state { Faker::Address.us_state }
  zip { Faker::Address.zip_code }
  country { Faker::Address.uk_country }
  email { Faker::Internet.email }
  contact { Faker::Name.name }
  phone { Faker::PhoneNumber.phone_number }  
end

User.blueprint do
  login { Faker::Name.name.gsub(/[^a-zA-Z]/, '') }
  email { Faker::Internet.email }
  password "insecure"
  password_confirmation "insecure"
  created_at Time.today
  updated_at Time.today
  rate 50
  color '123456'
end

Work.blueprint do
  client
  invoice
  user
  start Time.today
  finish Time.today + 1.hour
  rate 50
  notes { Faker::Lorem.sentence rand(3) }
end

Adjustment.blueprint do
  client
  invoice
  rate 0
  notes "adjustment"
end

Invoice.blueprint do
  client
  date Date.today
  project_name { Faker::Company.name }
end

Payment.blueprint do
  invoice
  total 0
end
