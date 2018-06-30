# frozen_string_literal: true

class Customer
  attr_reader :user, :token

  def initialize(card, user)
    @user = user
    @token = Token.create(card)
  end

  def self.create(card, user)
    new(card, user).create
  end

  def create
    return user.stripe_customer_id if user.stripe_customer_id?
    user.update(stripe_customer_id: customer.id)
    user.stripe_customer_id
  end

  private

  def customer
    Stripe::Customer.create(
      email: user.email,
      source: token,
      metadata: user.payment_metadata
    )
  end
end
