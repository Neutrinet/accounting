class MovementsController < ApplicationController
  helper_method :years, :year

  def index
    @report = Report.new(year)
  end

  private

  def year
    return params[:year] if years.include?(params[:year])
    
    years.first
  end

  def years
    @years ||= Movement.existing_years.map(&:to_s)
  end
end
