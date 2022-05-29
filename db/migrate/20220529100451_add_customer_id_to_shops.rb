class AddCustomerIdToShops < ActiveRecord::Migration[6.1]
  def change
    add_column :shops, :customer_id, :integer
  end
end
