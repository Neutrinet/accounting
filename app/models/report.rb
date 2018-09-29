class Report
  attr_reader :year

  def self.for(year)
    new(year)
  end

  def initialize(year)
    @year = year
  end

  def previous_balance
    @previous_balance ||= previous_movements.sum(:amount) 
  end

  def current_balance
    @current_balance ||= previous_balance + movements.sum(:amount)
  end

  def movements
    @movements ||= Movement.for_year(year).order(date: :desc, number: :desc)
  end

  private

  def previous_movements
    @previous_movements ||= Movement.before_year(year)
  end
end
