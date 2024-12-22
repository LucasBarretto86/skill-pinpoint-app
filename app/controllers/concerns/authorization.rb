# frozen_string_literal: true

module Authorization
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user_by_token!
  end

  private
    def authenticate_user_by_token!
      return unless request.format.json?

      token = request.headers["Authorization"]&.split(" ")&.last
      decoded_payload = JWT.decode(token, ENV["DEVISE_JWT_SECRET_KEY"]).first

      if (user = User.find(decoded_payload["sub"]))
        sign_in(user, store: false)
      end
    rescue JWT::DecodeError => error
      render json: { error: "Unauthorized: Invalid token", message: error.message }, status: :unauthorized
    rescue ActiveRecord::RecordNotFound => error
      render json: { error: "Unauthorized: User not found", message: error.message }, status: :unauthorized
    rescue StandardError => error
      pp error
    end
end
