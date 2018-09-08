class Movement < ApplicationRecord
  validates_uniqueness_of :number, scope: :date
  validates_presence_of :number, :date, :amount, :movement_type, :raw

  def self.from_row(movement_row)
    create(
      number: movement_row.number,
      date: movement_row.date,
      amount: movement_row.amount,
      iban: movement_row.iban,
      communication: movement_row.communication,
      movement_type: movement_row.movement_type,
      raw: movement_row.row
    )
  end
end
