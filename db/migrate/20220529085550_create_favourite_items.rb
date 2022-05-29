class CreateFavouriteItems < ActiveRecord::Migration[6.1]
  def change
    create_table :favourite_items do |t|

      t.integer :customer_id
      t.integer :item_id

      t.timestamps
    end
  end
end
