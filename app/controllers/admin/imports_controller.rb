require "csv"

class Admin::ImportsController < Admin::BaseController
  before_action :ensure_csv_file, only: [:create]

  def create
    nb_movements = Movement.count
    @errors = parse_csv
    @nb_imported_movements = Movement.count - nb_movements
  end

  private

  def ensure_csv_file
    return true if params[:csv_file]

    redirect_to action: :new
  end

  def parse_csv
    errors = []
    CSV.foreach(csv_file.path, encoding: "UTF-8", col_sep: ";", headers: true) do |row|
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
