# frozen_string_literal: true

class API::HealthCheckController < ActionController::API
  def show
    render json: { status: "healthy" }, status: :ok
  end
end
