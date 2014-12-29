class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.integer :post_id
      t.text :content

      t.timestamps
    end
    add_index :replies, :post_id
  end
end
