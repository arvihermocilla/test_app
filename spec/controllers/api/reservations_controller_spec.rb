require 'rails_helper'

RSpec.describe Api::ReservationsController, type: :request do
  describe '#create' do
    context 'when json payload is flat' do
      let(:payload) {
        {
          "start_date": "2021-03-12",
          "end_date": "2021-03-16",
          "nights": 4,
          "guests": 4,
          "adults": 2,
          "children": 2,
          "infants": 0,
          "status": "accepted",
          "guest": {
          "id": 1,
          "first_name": "Wayne",
          "last_name": "Woodbridge",
          "phone": "639123456789",
          "email": "wayne_woodbridge@bnb.com"
          },
          "currency": "AUD",
          "payout_price": "3800.00",
          "security_price": "500",
          "total_price": "4500.00"
        }
      }

      before do
        post '/api/reservations', params: payload
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(Guest.count).to eq(1) }
      it { expect(Reservation.count).to eq(1) }
    end

    context 'when json payload is not flat' do
      let(:payload) {
        {
          "reservation": {
            "start_date": "2021-03-12",
            "end_date": "2021-03-16",
            "expected_payout_amount": "3800.00",
            "guest_details": {
            "localized_description": "4 guests",
            "number_of_adults": 2,
            "number_of_children": 2,
            "number_of_infants": 0
            },
            "guest_email": "wayne_woodbridge@bnb.com",
            "guest_first_name": "Wayne",
            "guest_id": 1,
            "guest_last_name": "Woodbridge",
            "guest_phone_numbers": [
            "639123456789",
            "639123456789"
            ],
            "listing_security_price_accurate": "500.00",
            "host_currency": "AUD",
            "nights": 4,
            "number_of_guests": 4,
            "status_type": "accepted",
            "total_paid_amount_accurate": "4500.00"
          }
        }
      }

      before do
        post '/api/reservations', params: payload
      end

      it { expect(response).to have_http_status(:ok) }
      it { expect(Guest.count).to eq(1) }
      it { expect(Reservation.count).to eq(1) }
    end

    context 'when guest email already exists' do
      let(:guest) { create(:guest, email: 'wayne_woodbridge@bnb.com') }
      let(:payload) {
        {
          "start_date": "2021-03-12",
          "end_date": "2021-03-16",
          "nights": 4,
          "guests": 4,
          "adults": 2,
          "children": 2,
          "infants": 0,
          "status": "accepted",
          "guest": {
          "id": 1,
          "first_name": "Wayne",
          "last_name": "Woodbridge",
          "phone": "639123456789",
          "email": "wayne_woodbridge@bnb.com"
          },
          "currency": "AUD",
          "payout_price": "3800.00",
          "security_price": "500",
          "total_price": "4500.00"
        }
      }

      before do
        guest
        post '/api/reservations', params: payload
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(Guest.count).to eq(1) }
      it { expect(response.body).to include("Email has already been taken") }
    end
  end
end
