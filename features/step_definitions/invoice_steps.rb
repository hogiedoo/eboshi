Then /^I should see dates on the invoice$/ do
  page.body.should match /\d{2}\/\d{2}\/\d{2}/
end

Then /^I should not see any dates on the invoice$/ do
  page.body.should_not match /\d{2}\/\d{2}\/\d{2}/
end

Then /^I should see times on the invoice$/ do
  page.body.should match /\d{1,2}:\d{2}.[ap]m/i
end

Then /^I should not see any times on the invoice$/ do
  page.body.should_not match /\d{1,2}:\d{2}.[ap]m/i
end

When /^I edit the first invoice for "([^\"]*)"$/ do |name|
  client = Client.find_by_name name
  visit edit_invoice_path(client.invoices.first)
end

When /^I uncheck the first line item$/ do
  doc = Nokogiri::HTML(page.body)
  uncheck doc.css("input[type=checkbox]").first[:id]
end

Then /^I should see ([a-z]+) line items?$/ do |number|
  number = english_to_number number
  page.all(".line_item").length.should == number
end
