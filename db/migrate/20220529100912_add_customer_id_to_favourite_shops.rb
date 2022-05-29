class AddCustomerIdToFavouriteShops < ActiveRecord::Migration[6.1]
  def change
    add_column :favourite_shops, :customer_id, :integer
  end
end
