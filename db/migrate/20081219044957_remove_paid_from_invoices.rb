class RemovePaidFromInvoices < ActiveRecord::Migration
  def self.up
    Invoice.all(:conditions => "paid IS NOT NULL").each do |i|
      i.payments.create!(:total => i.total, :created_at => i.paid, :updated_at => i.paid)
    end
    remove_column :invoices, :paid
  end

  def self.down
    add_column :invoices, :paid, :datetime
    Payment.all.each do |p|
      p.invoice.paid = p.created_at
      p.save!
    end
    Payment.destroy_all
  end
end
