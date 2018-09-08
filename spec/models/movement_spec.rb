require 'rails_helper'

RSpec.describe Movement, type: :model do
  def new_movement(args = {})
    Movement.new(
      number: args.fetch(:number, "123"),
      date: args.fetch(:date, Time.zone.now),
      amount: args.fetch(:amount, 12.34),
      iban: args.fetch(:iban, "BE12123456781234"),
      communication: args.fetch(:communication, "This is a communication"),
      movement_type: args.fetch(:movement_type, "unknown"),
      raw: args.fetch(:raw, "the raw CSV row")
    )
  end

  def expect_required_field(field_name)
    movement = new_movement(field_name => nil)
    expect do
      movement.save(validate: false)
    end.to raise_error(ActiveRecord::NotNullViolation)
    expect(movement.save).to eql(false)
  end

  it "saves a movement to the database" do
    expect do
      new_movement.save
    end.to change { Movement.count }.by(1)
  end

  it "has a unique constraint on number/date" do
    date = Time.zone.now
    new_movement(date: date).save

    expect do
      new_movement(date: date).save(validate: false)
    end.to raise_error(ActiveRecord::RecordNotUnique)
    expect(new_movement(date: date).save).to eql(false)
  end

  it "has a required fields" do
    expect_required_field(:number)
    expect_required_field(:date)
    expect_required_field(:amount)
    expect_required_field(:movement_type)
    expect_required_field(:raw)
  end

  describe ".from_row" do
    let(:csv_row) { csv_rows("recordbank_vpn").first }
    let(:movement_row) { MovementRow.new(csv_row) }

    it "creates a movement from a CSV row" do
      expect do
        movement = Movement.from_row(movement_row)
      end.to change { Movement.count }.by(1)
    end

    it "maps all the fields correctly" do
      movement = Movement.from_row(movement_row)

      expect(movement.number).to eql(movement_row.number)
      expect(movement.date).to eql(DateTime.parse(movement_row.date).utc)
      expect(movement.amount).to eql(movement_row.amount)
      expect(movement.iban).to eql(movement_row.iban)
      expect(movement.communication).to eql(movement_row.communication)
      expect(movement.movement_type).to eql(movement_row.movement_type)
      expect(movement.raw).to eql(movement_row.row.to_s)
    end
  end
end
