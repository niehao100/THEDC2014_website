class CreateDuels < ActiveRecord::Migration
  def change
    create_table :duels do |t|
      t.integer :a_id
      t.integer :b_id
      t.integer :winner_id

      t.timestamps
    end
    add_index :duels, :a_id
    add_index :duels, :b_id
    add_index :duels, [:a_id, :b_id], unique: true
  end
end
