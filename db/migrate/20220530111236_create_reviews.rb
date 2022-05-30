class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|

      t.integer :customer_id
      t.integer :item_id
      t.text :review_comment
      t.integer :star

      t.timestamps
    end
  end
end
