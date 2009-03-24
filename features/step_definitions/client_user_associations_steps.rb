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

Given /^the user "(.+)" has the following pacts:$/ do |name, table|
  user = User.find_by_login name
  table.hashes.each do |row|
    user.clients << Client.find_by_name(row[:client])
  end
end
