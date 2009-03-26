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

Given /^the user "(.+)" has the following assignments:$/ do |name, table|
  user = User.find_by_login name
  table.hashes.each do |row|
    user.clients << Client.find_by_name(row[:client])
  end
end

And /^I click "(.+)" next to "(.+)"$/ do |link, context|
  within("li:contains('#{context}')") do
    click_link link
  end
end

Given /^I am on the invoices page for "(.+)"$/ do |name|
  client = Client.find_by_name name
  visit "/clients/#{client.id}/invoices"
end

Then /^visiting the invoices page for "(.+)" should return 404$/ do |name|
  client = Client.find_by_name name
  lambda { visit "/clients/#{client.id}/invoices" }.should raise_error ActiveRecord::RecordNotFound
end

Given /^a[n]? (.+) exists for "(.+)"$/ do |model_name, name|
  model = model_name.gsub(/ /, '_').classify.constantize
  client = Client.find_by_name name
  client.send(model_name.gsub(/ /, '_').pluralize.to_sym) << model.make
end

Then /^visiting that (.+) page should return 404$/ do |model_name|
  model = model_name.gsub(/ /, '_').classify.constantize
  record = model.first
  lambda { visit "/#{model_name.gsub(/ /, '_').pluralize}/#{record.id}" }.should raise_error ActiveRecord::RecordNotFound
end

Then /^visiting the new payment page for that invoice should return 404$/ do
  invoice = Invoice.first
  lambda { visit "/invoices/#{invoice.id}/payments/new" }.should raise_error ActiveRecord::RecordNotFound
end

Then /^I should see "(.+)" under "Clients"$/ do |name|
  response.should have_selector "h2:contains('Clients') ~ *:contains('#{name}')"
end

