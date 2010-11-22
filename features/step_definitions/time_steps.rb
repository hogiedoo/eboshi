Given /^today is "([^\"]*)"$/ do |date|
  Delorean.time_travel_to date
end
