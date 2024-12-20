# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Registrations", type: :system do
  let(:user) { create(:user) }

  context "When valid sign up data is sent" do
    it "login user and redirect to home page" do
      visit "/sign-up"

      fill_in "Email", with: user.email
      fill_in "Password", with: "password"

      click_button "Sign In"

      expect(page).to have_current_path(authenticated_root_path)
      expect(page).to have_content("Home")
      expect(page).to have_content("But, there's nothing to seen here...")
    end
  end

  context "When invalid sign up data is sent" do
    it "rerender the new session page with flash error" do
      visit "/sign-up"

      fill_in "Email", with: user.email
      fill_in "Password", with: "wrong_password"
      fill_in "Password", with: "wrong_password"

      click_button "Sign In"

      expect(page).to have_content("Invalid email or password.")
      expect(page).to have_content("Welcome!")
      expect(page).to have_content("Sign in and find the skill you need!")
    end
  end

  context "when clicking on sign in link" do
    it "redirects_to registration page" do
      visit "/sign-up"

      click_link "Sign up, pal!"

      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
