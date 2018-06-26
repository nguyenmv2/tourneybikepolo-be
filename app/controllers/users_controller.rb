# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    users = User.all

    render json: users
  end

  def show
    render json: @user
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created, location: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue
    error = { errors: { message: "Not Found" } }.to_json
    render json: error, status: :not_found unless @user
  end

  def user_params
    params.require(:user).permit(:first, :last, :nickname, :dob, :phone, :dob, :gender, :email, :bio, :avatar, :password)
  end
end
