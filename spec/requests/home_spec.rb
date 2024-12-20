# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Homes", type: :request do
  let!(:user) { create(:user) }

  before { login_as(user, scope: :user) }

  describe "GET #index" do
    it "returns http success" do
      get home_path
      expect(response).to have_http_status(:success)
    end
  end
end
