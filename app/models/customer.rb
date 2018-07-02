# frozen_string_literal: true

class Customer
  attr_reader :user, :token

  # Public: Initialize a Customer object.
  #
  # card - A hash of credit card information.
  # user - A User object
  def initialize(card, user)
    @user = user
    @token = Token.create(card)
  end

  # Public: Initializes a new Customer instance and calls #create.
  #
  # card - A hash of credit card information.
  # user - A User object
  #
  # Examples
  #
  #   card = {
  #     number: "4242424242424242",
  #     exp_month: 7,
  #     exp_year: 2019,
  #     cvc: "314" }
  #   user = User.find(1)
  #
  #   Customer.create(card, user)
  #   # => "cus_D9UbXfwgIlLJwc"
  #
  # Returns a string with the customer id.
  def self.create(card, user)
    new(card, user).create
  end

  # Public: Creates a new stripe customer id if the user doesn't already have
  # one and then updates the user record with the new id.
  #
  # Examples
  #
  #   customer = Customer.new(card, user)
  #   customer.create
  #   # => "cus_D9UbXfwgIlLJwc"
  #
  # Returns the stored Stripe::Customer id from the user table.
  def create
    return user.stripe_customer_id if user.stripe_customer_id?
    user.update(stripe_customer_id: customer.id)
    user.stripe_customer_id
  end

  private

  # Private: Creates a new customer through the Stripe API.
  #
  # Examples
  #
  #   customer
  #   # => Stripe::Customer
  #
  # Returns a Stripe::Customer object with the customer id and json attributes.
  def customer
    Stripe::Customer.create(
      email: user.email,
      source: token,
      metadata: user.payment_metadata
    )
  end
end
