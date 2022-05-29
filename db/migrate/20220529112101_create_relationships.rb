class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|

      t.references :customer, foreign_key: true
      t.references :follow, foreign_key: { to_table: :customers }

      t.timestamps
    end
  end
end
