Then /^I should see dates on the invoice$/ do
  response.body.should match /\d{2}\/\d{2}\/\d{2}/
end

Then /^I should not see any dates on the invoice$/ do
  response.body.should_not match /\d{2}\/\d{2}\/\d{2}/
end

Then /^I should see times on the invoice$/ do
  response.body.should match /\d{1,2}:\d{2}&nbsp;[ap]m/i
end

Then /^I should not see any times on the invoice$/ do
  response.body.should_not match /\d{1,2}:\d{2}&nbsp;[ap]m/i
end
