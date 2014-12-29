class CreateDocs < ActiveRecord::Migration
  def change
    create_table :docs do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
    add_index :docs, :title
  end
end
