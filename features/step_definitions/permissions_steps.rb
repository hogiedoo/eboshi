And /^I click "(.+)" next to "(.+)"$/ do |link, context|
  within("li:contains('#{context}')") do
    click_link link
  end
end

Then /^visiting the invoices page for "(.+)" should return 404$/ do |name|
  client = Client.find_by_name name
  lambda { visit "/clients/#{client.id}/invoices" }.should raise_error(ActiveRecord::RecordNotFound)
end

Then /^visiting that (\w+) (\w*)[ ]?page should return 404$/ do |model_name, action|
  model = model_name.gsub(/ /, '_').classify.constantize
  record = model.first
  url = "/#{model_name.gsub(/ /, '_').pluralize}/#{record.id}/#{action}"
  lambda { visit url }.should raise_error(ActiveRecord::RecordNotFound)
end

Then /^visiting the new payment page for that invoice should return 404$/ do
  invoice = Invoice.first
  lambda { visit "/invoices/#{invoice.id}/payments/new" }.should raise_error(ActiveRecord::RecordNotFound)
end


