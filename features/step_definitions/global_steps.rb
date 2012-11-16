Then /^I should not be able to go to (.+)$/ do |url|
  visit url
  page.status_code.should == 403
end

Given /^I am signed in as "Micah"$/ do
  Given 'a user "Micah" exists with name: "Micah"'
  @user = User.find_by_name "Micah"
  visit "/"
  fill_in "Email", :with => @user.email
  fill_in "Password", :with => "secret"
  click_button "Login"
  Then 'I should see "Welcome, Micah!"'
end

Given /^I am signed in as an Admin$/ do
  Given 'a user "Admin" exists with name: "Admin", admin: true'
  @user = User.find_by_name "Admin"
  visit "/"
  fill_in "Email", :with => @user.email
  fill_in "Password", :with => "secret"
  click_button "Login"
  Then 'I should see "Welcome, Admin!"'
end

Given /^I worked (\d+) hours for "([^\"]*)" on "([^\"]*)"$/ do |hours, client_name, date|
  date = Time.zone.parse(date)
  client = Client.find_by_name(client_name)
  client.works.make :start => date, :finish => date + hours.to_f.hours, :user => @user
end

Given /^I worked (\d+) hours for "([^\"]*)" today$/ do |hours, client_name|
  client = Client.find_by_name(client_name)
  client.works.make :start => Time.zone.today + 1.hour, :finish => Time.zone.today + 1.hour + hours.to_f.hours, :user => @user
end

Then /^I should see "([^\"]*)" next to "([^\"]*)"$/ do |text, context|
  page.should have_css("*:contains('#{context}') ~ *:contains('#{text}')")
end

Then /^I should see "(.+)" under "(.+)"$/ do |name, heading|
  page.should have_css("h2:contains('#{heading}') ~ *:contains('#{name}')")
end

Then /^I should not see "(.+)" under "(.+)"$/ do |name, heading|
  page.should_not have_css("h2:contains('#{heading}') ~ *:contains('#{name}')")
end
