class AddIncludeDatesToInvoices < ActiveRecord::Migration
  def self.up
    add_column :invoices, :include_dates, :boolean, :null => false, :default => 0
  end

  def self.down
    remove_column :invoices, :include_dates
  end
end
