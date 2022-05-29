class AddShopIdToFavouriteShops < ActiveRecord::Migration[6.1]
  def change
    add_column :favourite_shops, :shop_id, :integer
  end
end
