# frozen_string_literal: true

class ChargesController < ApplicationController
  rescue_from Stripe::CardError, with: :render_card_error

  def create
    user = current_user
    tournament = Tournament.find(params[:tournament_id])
    payment = PaymentService.new(params[:card], user, tournament)

    payment.charge
  end

  private

  def render_not_found(e)
    error = { errors: { message: e } }.to_json
    render json: error, status: :payment_required
  end
end
