class AddCustomLabelToMovements < ActiveRecord::Migration[5.2]
  def change
    add_column :movements, :custom_label, :string, default: nil
  end
end
