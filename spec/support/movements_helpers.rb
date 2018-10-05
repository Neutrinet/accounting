module MovementsHelpers
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
end
