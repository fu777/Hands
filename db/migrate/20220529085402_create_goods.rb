class CreateGoods < ActiveRecord::Migration[6.1]
  def change
    create_table :goods do |t|

      t.integer :customer_id
      t.integer :blog_id

      t.timestamps
    end
  end
end
