# frozen_string_literal: true

class PaymentService
  attr_reader :customer_id, :tournament

  def initialize(card, user, tournament)
    @customer_id = Customer.create(card, user)
    @tournament = tournament
  end

  def charge
    Stripe::Charge.create(
      customer: customer_id,
      amount: tournament.fee.cents,
      description: "Registration fee for #{tournament.name}",
      currency: tournament.fee.currency
    )
  end
end
