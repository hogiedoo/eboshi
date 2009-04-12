class AddLogosTable < ActiveRecord::Migration
  def self.up
    add_column :users, :logo_file_name,    :string
    add_column :users, :logo_content_type, :string
    add_column :users, :logo_file_size,    :integer
    add_column :users, :logo_updated_at,   :datetime

    create_table :logos do |t|
      t.string :style
      t.integer :user_id
      t.timestamps
    end
    execute 'ALTER TABLE logos ADD COLUMN file_contents LONGBLOB'
  end

  def self.down
    drop_table :logos

    remove_column :users, :logo_file_name
    remove_column :users, :logo_content_type
    remove_column :users, :logo_file_size
    remove_column :users, :logo_updated_at
  end
end
