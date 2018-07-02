# frozen_string_literal: true

class ChargesController < ApplicationController
  rescue_from Stripe::CardError, with: :render_card_error

  def create
    user = current_user
    tournament = Tournament.find(charge_params[:tournament_id])
    payment = PaymentService.new(charge_params[:card], user, tournament)

    render json: payment.charge.to_json, status: :created
  end

  private

  def render_card_error(e)
    error = { errors: { message: e } }.to_json
    render json: error, status: :payment_required
  end

  def charge_params
    params.permit(:tournament_id, card: [:number, :exp_month, :exp_year, :cvc])
  end
end
