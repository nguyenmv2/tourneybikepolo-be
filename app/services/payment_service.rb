# frozen_string_literal: true

class PaymentService
  attr_reader :customer_id, :tournament

  # Public: Initialize a Customer object.
  #
  # card - A hash of credit card information.
  # user - A User object
  # tournament - A Tournament object
  def initialize(card, user, tournament)
    @customer_id = Customer.create(card, user)
    @tournament = tournament
  end

  # Public: Creates a new stripe charge for the amount stored on the tournament
  # table to the user passed to the class.
  #
  # Examples
  #
  #   card = {
  #     number: "4242424242424242",
  #     exp_month: 7,
  #     exp_year: 2019,
  #     cvc: "314" }
  #   user = User.find(1)
  #   tournament = Tournament.find(1)

  #   service = PaymentService.new(card, user, tournament)
  #   service.create
  #   # => Stripe::Charge
  #
  # Returns a Stripe::Charge object with a charge id and json attributes.
  def charge
    Stripe::Charge.create(
      customer: customer_id,
      amount: tournament.fee.cents,
      description: "Registration fee for #{tournament.name}",
      currency: tournament.fee.currency
    )
  end
end
