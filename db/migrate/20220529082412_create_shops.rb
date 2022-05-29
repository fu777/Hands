class CreateShops < ActiveRecord::Migration[6.1]
  def change
    create_table :shops do |t|

      t.string :name
      t.text :introduction
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
