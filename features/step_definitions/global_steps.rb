Given /^I am on "(.+)"$/ do |url|
  visit url
end

Then /^I should not be able to go to "([^\"]*)"$/ do |url|
  lambda { visit url }.should raise_error
end

Given /^I am signed in as "Micah"$/ do
  @user = User.make :login => "Micah", :password => "insecure", :password_confirmation => "insecure"
  visit "/"
  fill_in "login", :with => "Micah"
  fill_in "password", :with => "insecure"
  click_button "Login"
  response.should contain "Welcome,"
  response.should contain "Micah!"
end

Given /^I am signed in as an Admin$/ do
  @user = User.make :login => "Admin", :password => "insecure", :password_confirmation => "insecure", :admin => true
  visit "/"
  fill_in "login", :with => "Admin"
  fill_in "password", :with => "insecure"
  click_button "Login"
  response.should contain "Welcome,"
  response.should contain "Admin!"
end

Given /^the following (.+) exist:$/ do |model, table|
  model = model.singularize.capitalize.constantize
  table.hashes.each do |row|
    model.make row
  end
end
