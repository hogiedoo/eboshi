Given /^I visit the new payment page for that invoice$/ do
  invoice = Invoice.first
  visit new_payment_path(invoice)
end
