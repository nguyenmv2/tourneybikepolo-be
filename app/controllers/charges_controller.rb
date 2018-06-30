# frozen_string_literal: true

class ChargesController < ApplicationController
  def create
    user = current_user
    tournament = Tournament.find(params[:tournament_id])
    payment = PaymentService.new(params[:card], user, tournament)

    payment.charge
  rescue Stripe::CardError => e
    flash[:error] = e.message
  end
end
