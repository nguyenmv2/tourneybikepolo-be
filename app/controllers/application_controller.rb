# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Knock::Authenticable
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def render_not_found
    error = { errors: { message: "Not Found" } }.to_json
    render json: error, status: :not_found
  end
end
