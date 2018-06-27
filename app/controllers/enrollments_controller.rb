# frozen_string_literal: true

class EnrollmentsController < ApplicationController
  before_action :authenticate_user
  before_action :set_enrollment, only: [:destroy]

  def create
    enrollment = Enrollment.new(enrollment_params)

    if enrollment.save
      render json: enrollment, status: :created, location: enrollment
    else
      render json: enrollment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @enrollment.destroy
  end

  private

  def set_enrollment
    @enrollment = Enrollment.find(params[:id])
  rescue
    error = { errors: { message: "Not Found" } }.to_json
    render json: error, status: :not_found unless @enrollment
  end

  def enrollment_params
    params.require(:enrollment).permit(:team_id, :tournament_id)
  end
end
