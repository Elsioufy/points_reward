class AddParentIdToUser < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :parent_id, :integer, null: true, index: true
    add_foreign_key :users, :users, column: :parent_id
  end

  def down
    remove_column :users, :parent_id
  end
end
