class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.boolean :survived, default: true

      t.timestamps
    end
    add_index :teams, [:name, :survived]
  end
end
