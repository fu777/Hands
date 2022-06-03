class AddLimitToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :limit, :integer
  end
end
