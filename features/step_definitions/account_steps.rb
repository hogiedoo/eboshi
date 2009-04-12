When /^I upload a logo image$/ do
  attach_file "Logo", "features/support/images/logo.gif"
end

When /^I upload a signature$/ do
  attach_file "Signature", "features/support/images/signature.gif"
end

Then /^the logo should say "([^\"]*)"$/ do |text|
  response.should have_selector "#logo:contains('#{text}')"
end

Then /^the signature should say "([^\"]*)"$/ do |text|
  response.should have_selector "#sig:contains('#{text}')"
end

Then /^the logo should be an image$/ do
  response.should have_selector "#logo img"
end

Then /^the signature should be an image$/ do
  response.should have_selector "#sig img"
end



