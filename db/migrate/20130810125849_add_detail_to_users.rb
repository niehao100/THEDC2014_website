class AddDetailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :department, :string
    add_column :users, :from_class, :string
  end
end
