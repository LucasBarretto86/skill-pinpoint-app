# frozen_string_literal: true

class API::SessionsController < Devise::SessionsController
  protect_from_forgery with: :null_session
  respond_to :json

  def create
    @user = User.find_by(email: session_params[:email])

    if @user&.valid_password?(session_params[:password])
      token = Warden::JWTAuth::UserEncoder.new.call(@user, :user, "").first
      render json: { user_id: @user.id, token: token }, status: :ok
    else
      render json: { error: "Invalid email or password." }, status: :unauthorized
    end
  end

  private
    def session_params
      params.require(:user).permit(:email, :password)
    end
end
