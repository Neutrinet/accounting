class Movement < ApplicationRecord
  validates_uniqueness_of :number, scope: :date
  validates_presence_of :number, :date, :amount, :iban, :movement_type, :raw
end
