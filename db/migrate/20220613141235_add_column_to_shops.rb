class AddColumnToShops < ActiveRecord::Migration[6.1]
  def change
    add_index :shops, :customer_id, unique: true
  end
end
