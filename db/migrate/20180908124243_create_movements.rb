class CreateMovements < ActiveRecord::Migration[5.2]
  def change
    create_table :movements do |t|
      t.string :number, null: false
      t.datetime :date, null: false
      t.float :amount, null: false
      t.string :iban, null: false
      t.text :communication, default: nil
      t.string :movement_type, null: false
      t.text :raw, null: false

      t.timestamps
    end
    add_index(:movements, [:number, :date], unique: true)
  end
end
