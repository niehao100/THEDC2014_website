class AddPhoneNumToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone_num, :integer, limit: 8
  end
end
