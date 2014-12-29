class AddShowTimeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :show_time, :datetime
    add_index :events, :show_time
  end
end
