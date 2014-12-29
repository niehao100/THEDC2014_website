class CreateApplies < ActiveRecord::Migration
  def change
    create_table :applies do |t|
      t.integer :team_id
      t.integer :user_id

      t.timestamps
    end
    add_index :applies, :team_id
    add_index :applies, :user_id
    add_index :applies, [:team_id, :user_id], unique: true
  end
end
