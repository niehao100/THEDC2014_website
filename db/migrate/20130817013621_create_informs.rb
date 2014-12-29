class CreateInforms < ActiveRecord::Migration
  def change
    create_table :informs do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
