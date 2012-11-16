When /^I check all time items$/ do
  checkboxes = find_all_tag :tag => "input", :attributes => { :type => "checkbox" }
  checkboxes.each do |checkbox|
    check checkbox.attributes["id"]
  end
end

Given /^a time item for "(.+)"$/ do |client_name|
  @client = Client.find_by_name client_name
  @client.line_items << Work.make(:invoice => nil)
end

Then /^I should see "(.+)" in a line item$/ do |text|
  page.should have_css(".line_item:contains('#{text}')")
end

Then /^I should not see "(.+)" in a line item$/ do |text|
  page.should_not have_css(".line_item:contains('#{text}')")
end
