require "csv"

module FixturesHelpers
  def csv_rows(name)
    path = file_fixture("movements/#{name}.csv")
    rows = []
    options = { col_sep: ";", headers: true }
    CSV.foreach(path, options) do |row|
      rows << row
    end
    rows
  end
end
