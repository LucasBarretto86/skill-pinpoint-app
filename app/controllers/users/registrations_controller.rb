# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  layout "users/sessions"

  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)

    if @user.save!
      redirect_to root_path, notice: "Thanks for signing up!"
    else
      render :new, flash: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
