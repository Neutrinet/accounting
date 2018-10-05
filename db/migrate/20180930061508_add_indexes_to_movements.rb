class AddIndexesToMovements < ActiveRecord::Migration[5.2]
  def change
    add_index :movements, :movement_type
  end
end
