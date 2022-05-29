class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|

      t.integer :category_id
      t.integer :shop_id
      t.string :name
      t.text :introduction
      t.string :size
      t.string :shipping_date
      t.integer :price
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
