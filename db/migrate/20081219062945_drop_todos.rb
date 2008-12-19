class DropTodos < ActiveRecord::Migration
  def self.up
    drop_table :todos
  end

  def self.down
    create_table "todos", :force => true do |t|
      t.integer  "client_id",  :limit => 8
      t.integer  "user_id",    :limit => 8
      t.text     "notes"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
