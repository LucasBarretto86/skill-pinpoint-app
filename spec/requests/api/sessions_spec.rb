# frozen_string_literal: true

require "rails_helper"

RSpec.describe API::SessionsController, type: :request do
  describe "POST #create" do
    let(:user) { create(:user) }

    it "returns http success" do
      post "/api/sign-in", params: { user: { email: user.email, password: user.password } }
      expect(response).to have_http_status(:success)
      expect(response_body).to have_key("token")
    end

    it "returns error response if credentials are wrong" do
      post "/api/sign-in", params: { user: { email: user.email, password: "wrong_password" } }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
