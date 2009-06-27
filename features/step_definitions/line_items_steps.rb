When /^I check all time items$/ do
  checkboxes = find_all_tag :tag => "input", :attributes => { :type => "checkbox" }
  checkboxes.each do |checkbox|
    check checkbox.attributes["id"]
  end
end

Given /^a time item for "(.+)"$/ do |client_name|
  @client = Client.find_by_name client_name
  @client.line_items << Work.make(:invoice => nil)
  debugger
end
