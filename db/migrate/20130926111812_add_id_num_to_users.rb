class AddIdNumToUsers < ActiveRecord::Migration
  def change
    add_column :users, :id_num, :integer
  end
end
