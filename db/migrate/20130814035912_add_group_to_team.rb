class AddGroupToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :group, :string
    add_index :teams, :group
  end
end
