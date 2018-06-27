# frozen_string_literal: true

class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :update, :destroy]

  def index
    @tournaments = Tournament.all

    render json: @tournaments
  end

  def show
    render json: @tournament
  end

  def create
    @tournament = Tournament.new(tournament_params)

    if @tournament.save
      render json: @tournament, status: :created, location: @tournament
    else
      render json: @tournament.errors, status: :unprocessable_entity
    end
  end

  def update
    if @tournament.update(tournament_params)
      render json: @tournament
    else
      render json: @tournament.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @tournament.destroy
  end

  private

  def set_tournament
    @tournament = Tournament.find(params[:id])
  rescue
    error = { errors: { message: "Not Found" } }.to_json
    render json: error, status: :not_found unless @tournament
  end

  def tournament_params
    params.require(:tournament).permit(
      :name, :start_date, :end_date, :registration_start_date,
      :registration_end_date, :description, :team_cap
    )
  end
end
