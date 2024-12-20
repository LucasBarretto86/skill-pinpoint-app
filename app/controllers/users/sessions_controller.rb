# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :html, :turbo_stream

  def new
    super
  end

  def create
    @user = User.find_by(email: session_params[:email])

    if @user.valid_password?(session_params[:password])
      sign_in(@user)
      redirect_to root_path, status: :ok, flash: { success: "Welcome #{@user.email}!" }
    else
      render :new, flash: { error: I18n.t("devise.failure.invalid") }, status: :unprocessable_entity
    end
  end

  private
    def session_params
      params.require(:user).permit(:email, :password)
    end
end
