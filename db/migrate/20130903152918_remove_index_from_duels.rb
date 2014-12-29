class RemoveIndexFromDuels < ActiveRecord::Migration
  def change
    remove_index :duels, column: [:a_id, :b_id]
  end
end
