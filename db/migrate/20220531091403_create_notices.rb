class CreateNotices < ActiveRecord::Migration[6.1]
  def change
    create_table :notices do |t|

      t.integer :good_id
      t.integer :blog_comment_id
      t.integer :blog_id
      t.integer :visitor_id
      t.integer :visited_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
    
    add_index :notices, :visitor_id
    add_index :notices, :visited_id
    add_index :notices, :good_id
    add_index :notices, :blog_comment_id
    add_index :notices, :blog_id
    
  end
end
