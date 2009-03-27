Given /^I visit the new payment page for that invoice$/ do
  invoice = Invoice.first
  visit "/invoices/#{invoice.id}/payments/new"
end
