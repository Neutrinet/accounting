class Admin::MovementsController < ApplicationController
  def index
    @movements = Movement.all
    @unknown_movements = Movement.unknown
    @no_iban_movements = Movement.where(iban: nil).where.not(movement_type: "vpn")
  end
end
