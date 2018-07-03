# frozen_string_literal: true

class Token
  attr_reader :number, :exp_month, :exp_year, :cvc

  def initialize(number, exp_month, exp_year, cvc)
    @number = number
    @exp_month = exp_month
    @exp_year = exp_year
    @cvc = cvc
  end

  def self.create(card)
    new(card[:number], card[:exp_month], card[:exp_year], card[:cvc]).create
  end

  def create
    Stripe::Token.create(
      card: {
        number: number,
        exp_month: exp_month,
        exp_year: exp_year,
        cvc: cvc
      }
    )
  end
end
