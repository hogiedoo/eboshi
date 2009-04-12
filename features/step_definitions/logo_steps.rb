When /^I upload a logo image$/ do
  attach_file "Logo", "public/images/invoice/logo.gif"
end

Then /^the logo should say "([^\"]*)"$/ do |text|
  response.should have_selector "#logo:contains('#{text}')"
end

Then /^the logo should be an image$/ do
  response.should have_selector "#logo img"
end

