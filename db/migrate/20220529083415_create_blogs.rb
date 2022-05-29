class CreateBlogs < ActiveRecord::Migration[6.1]
  def change
    create_table :blogs do |t|

      t.integer :customer_id
      t.string :title
      t.text :body
      t.integer :item_id

      t.timestamps
    end
  end
end
