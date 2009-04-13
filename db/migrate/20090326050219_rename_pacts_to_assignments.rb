class RenamePactsToAssignments < ActiveRecord::Migration
  def self.up
    rename_table :pacts, :assignments
  end

  def self.down
    rename_table :assignments, :pacts
  end
end
