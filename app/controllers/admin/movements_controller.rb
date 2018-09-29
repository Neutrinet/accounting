class Admin::MovementsController < Admin::BaseController
  helper_method :years, :year

  def index
    @movements = Movement.for_year(year)
    @unknown_movements = Movement.for_year(year).unknown
    @no_iban_movements = Movement.for_year(year).where(iban: nil).where.not(movement_type: "vpn")
  end

  def edit
    @movement = Movement.find(params[:id])
  end

  def update
    Movement.find(params[:id]).update(update_params)
    redirect_to action: :index
  end

  private

  def update_params
    params.require(:movement).permit(:movement_type)  
  end

  def years
    @years ||= Movement.existing_years.map(&:to_s)
  end

  def year
    return params[:year] if years.include?(params[:year])
    
    years.first
  end
end
