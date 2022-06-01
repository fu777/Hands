class CreateChecks < ActiveRecord::Migration[6.1]
  def change
    create_table :checks do |t|

      t.integer :shop_visitor_id
      t.integer :shop_visited_id
      t.integer :order_id
      t.integer :visitor_id
      t.integer :visited_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end

    add_index :checks, :visitor_id
    add_index :checks, :visited_id
    add_index :checks, :shop_visitor_id
    add_index :checks, :shop_visited_id
    add_index :checks, :order_id

  end
end
