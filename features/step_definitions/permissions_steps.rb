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

Then /^visiting that (.+) page should return 404$/ do |model_name|
  model = model_name.gsub(/ /, '_').classify.constantize
  record = model.first
  lambda { visit "/#{model_name.gsub(/ /, '_').pluralize}/#{record.id}" }.should raise_error ActiveRecord::RecordNotFound
end

Then /^visiting the new payment page for that invoice should return 404$/ do
  invoice = Invoice.first
  lambda { visit "/invoices/#{invoice.id}/payments/new" }.should raise_error ActiveRecord::RecordNotFound
end


