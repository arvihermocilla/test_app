module Api
  class ReservationsController < ApplicationController
    def create
      form = ReservationForm.new(params.permit!)
      guest = Guest.new(form.attributes[:guest_attr])

      if guest.save
        guest.reservations.create!(form.attributes[:reservation_attr])
        render json: { message: "Reservation created successfully" }, status: :ok
      else
        render json: { errors: guest.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end
