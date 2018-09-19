class Admin::MovementsController < Admin::BaseController
  def index
    @movements = Movement.all
    @unknown_movements = Movement.unknown
    @no_iban_movements = Movement.where(iban: nil).where.not(movement_type: "vpn")
  end

  def edit
    @movement = Movement.find(params[:id])
  end

  def update
    redirect_to action: :index
  end
end
