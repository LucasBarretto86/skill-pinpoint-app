# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :html, :turbo_stream

  def new
  end

  def create
    @user = User.find_by(email: session_params[:email])

    if @user&.valid_password?(session_params[:password])
      sign_in(@user)
      redirect_to authenticated_root_path, flash: { success: "Welcome #{@user.email}!" }
    else
      flash.now[:error] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out(current_user)
    redirect_to unauthenticated_root_path, flash: { success: "Logged out!" }
  end

  private
    def session_params
      params.require(:user).permit(:email, :password)
    end
end
