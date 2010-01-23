class AddShowSummariesToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :show_summaries, :boolean, :default => true
  end

  def self.down
    remove_column :users, :show_summaries
  end
end
