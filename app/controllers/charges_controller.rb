# frozen_string_literal: true

class ChargesController < ApplicationController
  rescue_from Stripe::CardError, with: :render_card_error

  def create
    payment = PaymentService.new(charge_params[:card], objects)

    render json: payment.charge.to_json, status: :created
  end

  private

  def render_card_error(e)
    error = { errors: { message: e } }.to_json
    render json: error, status: :payment_required
  end

  def objects
    { user: current_user,
      tournament: Tournament.find(charge_params[:tournament_id]),
      team: Team.find(charge_params[:team_id]) }
  end

  def charge_params
    params.permit(:tournament_id, :team_id, card: %i[number exp_month exp_year cvc])
  end
end
