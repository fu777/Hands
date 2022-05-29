class CreateFavouriteShops < ActiveRecord::Migration[6.1]
  def change
    create_table :favourite_shops do |t|

      t.integer :customer_id
      t.integer :shop_id

      t.timestamps
    end
  end
end
