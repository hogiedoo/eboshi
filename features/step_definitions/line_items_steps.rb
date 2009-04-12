When /^I check all time items$/ do
  checkboxes = find_all_tag :tag => "input", :attributes => { :type => "checkbox" }
  checkboxes.each do |checkbox|
    check checkbox.attributes["id"]
  end
end
