# frozen_string_literal: true

class TournamentStaffsController < ApplicationController
  before_action :set_tournament_staff, only: [:show, :update, :destroy]

  def index
    @tournament_staffs = TournamentStaff.all

    render json: @tournament_staffs
  end

  def show
    render json: @tournament_staff
  end

  def create
    @tournament_staff = TournamentStaff.new(tournament_staff_params)

    if @tournament_staff.save
      render json: @tournament_staff, status: :created, location: @tournament_staff
    else
      render json: @tournament_staff.errors, status: :unprocessable_entity
    end
  end

  def update
    if @tournament_staff.update(tournament_staff_params)
      render json: @tournament_staff
    else
      render json: @tournament_staff.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @tournament_staff.destroy
  end

  private

  def set_tournament_staff
    @tournament_staff = TournamentStaff.find(params[:id])
  end

  def tournament_staff_params
    params.require(:tournament_staff).permit(:user_id, :tournament_id, :role)
  end
end
