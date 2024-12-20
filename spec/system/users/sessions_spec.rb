# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Sessions", type: :system do
  let(:user) { create(:user) }

  before do
    driven_by(:rack_test)
  end

  context "When valid data is sent" do
    it "login user and redirect to home page" do

    end
  end

  context "When invalid login data is sent" do
    it "rerender the new session page with flash error" do
    end
  end
end
