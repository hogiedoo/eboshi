Given /^I am on "(.+)"$/ do |url|
  visit url
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

Given /^the following (.+) exist:$/ do |model, table|
  model = model.singularize.capitalize.constantize
  table.hashes.each do |row|
    model.make row
  end
end
