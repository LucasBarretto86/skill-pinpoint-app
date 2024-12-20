# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Home", type: :system do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :user)
    visit "/"
  end

  describe "Home page features and contents" do
    it "have correct nav links" do
      expect(page).to have_link("About", href: "/")
      expect(page).to have_link("Sign Out", href: "/sign-out")
    end

    it "renders home page content" do
      expect(page).to have_current_path(home_path)
      expect(page).to have_text("Home")
      expect(page).to have_content("But, there's nothing to seen here...")
    end

    context "when clicking Sign Out option" do
      it "signs out user" do
        click_link "Sign Out"

        expect(page).to have_text("Signed out!")
        expect(page).to have_field("Email")
        expect(page).to have_field("Password")
      end
    end
  end
end
