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
  args = [model.first]
  args.unshift action.to_sym unless action.blank?
  lambda { visit polymorphic_path(args) }.should raise_error(ActiveRecord::RecordNotFound)
end

Then /^visiting the new payment page for that invoice should return 404$/ do
  invoice = Invoice.first
  lambda { visit new_payment_path(invoice) }.should raise_error(ActiveRecord::RecordNotFound)
end


