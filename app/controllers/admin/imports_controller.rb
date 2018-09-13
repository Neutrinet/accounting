require "csv"

class Admin::ImportsController < Admin::BaseController
  def new; end

  def create
    Movement.delete_all
    nb_movements = Movement.count
    @errors = parse_csv
    @nb_imported_movements = Movement.count - nb_movements
  end

  private

  def parse_csv
    errors = []
    CSV.foreach(csv_file.path, encoding: "ISO-8859-1", col_sep: ";", headers: true) do |row|
      movement_row = MovementRow.new(row)
      movement = Movement.from_row(movement_row)
      errors << movement unless movement.persisted?
    end
    errors
  end

  def csv_file
    params[:csv_file]
  end
end
