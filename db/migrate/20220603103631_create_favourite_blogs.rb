class CreateFavouriteBlogs < ActiveRecord::Migration[6.1]
  def change
    create_table :favourite_blogs do |t|

      t.integer :customer_id
      t.integer :blog_id

      t.timestamps
    end
  end
end
