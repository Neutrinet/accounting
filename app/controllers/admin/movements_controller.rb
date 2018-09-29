class Admin::MovementsController < Admin::BaseController
  helper_method :years, :year, :movement_types, :movement_type

  def index
    @movements = Movement.for_year(year).for_movement_type(movement_type).order(date: :desc, number: :desc)
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

  def movement_types
    @movement_types ||= Movement::ALLOWED_TYPES.merge(nil => "Tous les mouvements")
  end

  def valid_movement_key?
    return movement_types.keys.include?(params[:movement_type])
  end

  def movement_type
    valid_movement_key? ? params[:movement_type] : nil
  end
end
