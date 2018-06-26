# frozen_string_literal: true

class RostersController < ApplicationController
  before_action :set_roster, only: [:show, :update, :destroy]

  def index
    rosters = Roster.all

    render json: rosters
  end

  def show
    render json: @roster
  end

  def create
    roster = Roster.new(roster_params)

    if roster.save
      render json: roster, status: :created, location: roster
    else
      render json: roster.errors, status: :unprocessable_entity
    end
  end

  def update
    if @roster.update(roster_params)
      render json: @roster
    else
      render json: @roster.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @roster.destroy
  end

  private

  def set_roster
    @roster = Roster.find(params[:id])
  rescue
    error = { errors: { message: "Not Found" } }.to_json
    render json: error, status: :not_found unless @roster
  end

  def roster_params
    params.require(:roster).permit(:user_id, :team_id, :role)
  end
end
