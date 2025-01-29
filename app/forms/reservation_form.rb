class ReservationForm
  include ActiveModel::Model
  attr_accessor :reservation, :start_date, :end_date, :nights, :guests, :adults,
                :children, :infants, :status, :guest, :guests, :currency,
                :payout_price, :security_price, :total_price

  def initialize(options = {})
    super(options.except("controller", "action"))
    attributes
  end

  def attributes
    {
      guest_attr: guest_attributes,
      reservation_attr: reservation_attributes
    }
  end

  private

  def guest_attributes
    {
      id: guest&.dig(:id) || reservation[:guest_id],
      first_name: guest&.dig(:first_name) || reservation[:guest_first_name],
      last_name: guest&.dig(:last_name) || reservation[:guest_last_name],
      phone_number: [ guest&.dig(:phone) ] || reservation[:guest_phone_numbers],
      email: guest&.dig(:email) || reservation[:guest_email]
    }
  end

  def reservation_attributes
    {
      start_date: start_date || reservation[:start_date],
      end_date: end_date || reservation[:end_date],
      nights: nights || reservation[:nights],
      number_of_guests: guests || reservation[:number_of_guests],
      number_of_adults: adults || reservation[:guest_details][:number_of_adults],
      number_of_children: children || reservation[:guest_details][:number_of_children],
      number_of_infants: infants || reservation[:guest_details][:number_of_infants],
      status: status || reservation[:status_type],
      currency: currency || reservation[:host_currency],
      payout_price: payout_price || reservation[:expected_payout_amount],
      security_price: security_price || reservation[:listing_security_price_accurate],
      total_price: total_price || reservation[:total_paid_amount_accurate]
    }
  end
end
