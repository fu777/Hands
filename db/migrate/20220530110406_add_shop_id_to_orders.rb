class AddShopIdToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :shop_id, :integer
  end
end
