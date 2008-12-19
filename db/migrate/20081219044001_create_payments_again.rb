class CreatePaymentsAgain < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.belongs_to :invoice
      t.decimal :total, :precision => 10, :scale => 2
      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end

