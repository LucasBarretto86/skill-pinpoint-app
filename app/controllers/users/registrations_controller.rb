# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  layout "users/sessions"

  def new
    @user = User.new
  end

  def create
    @user = User.new(registration_params)

    if @user.save
      sign_in(@user)
      redirect_to home_path, success: "Thanks for signing up!", status: :created
    else
      render :new, flash: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    def registration_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
