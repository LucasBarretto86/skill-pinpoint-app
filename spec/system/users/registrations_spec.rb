# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Registrations", type: :system do
  context "When valid sign up data is sent" do
    it "creates user, sign it in and redirect to home page" do
      visit "/sign-up"

      fill_in "Email", with: Faker::Internet.email
      fill_in "Password", with: "password"
      fill_in "Repeat password", with: "password"

      click_button "Sign Up"

      expect(page).to have_current_path(home_path)
    end
  end

  context "When invalid sign up data is sent" do
    it "rerender form and show field errors" do
      visit "/sign-up"

      fill_in "Email", with: ""
      fill_in "Password", with: "pass"
      fill_in "Repeat password", with: "wrong-password"

      click_button "Sign Up"

      expect(page).to have_text("can't be blank")
      expect(page).to have_text("is too short (minimum is 8 characters)")
      expect(page).to have_content("doesn't match Password")
    end
  end

  context "when clicking on sign in link" do
    it "redirects_to registration page" do
      visit "/sign-up"

      click_link "Sign-in here!"

      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
