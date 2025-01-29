module Api
  class ReservationsController < ApplicationController
    def create
      # create form object that will parse the input
      form = ReservationForm.new(params.permit!)
      guest = Guest.create(form.attributes[:guest_attr])
      guest.reservations.create(form.attributes[:reservation_attr])

      render json: { message: "Reservation created successfully" }, status: 200
    end
  end
end
