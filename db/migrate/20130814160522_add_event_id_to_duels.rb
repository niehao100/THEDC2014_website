class AddEventIdToDuels < ActiveRecord::Migration
  def change
    add_column :duels, :event_id, :integer
    add_index :duels, :event_id
  end
end
