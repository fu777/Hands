class CreateBlogComments < ActiveRecord::Migration[6.1]
  def change
    create_table :blog_comments do |t|

      t.integer :customer_id
      t.integer :blog_id
      t.text :comment

      t.timestamps
    end
  end
end
