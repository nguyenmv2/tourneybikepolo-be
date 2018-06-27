# frozen_string_literal: true

class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :update, :destroy]

  def show
    render json: @team
  end

  def create
    team = Team.new(team_params)

    if team.save
      render json: team, status: :created, location: team
    else
      render json: team.errors, status: :unprocessable_entity
    end
  end

  def update
    if @team.update(team_params)
      render json: @team
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @team.destroy
  end

  private

  def set_team
    @team = Team.find(params[:id])
  rescue
    error = { errors: { message: "Not Found" } }.to_json
    render json: error, status: :not_found unless @team
  end

  def team_params
    params.require(:team).permit(
      :name, :description, :logo, :player_count
    )
  end
end
