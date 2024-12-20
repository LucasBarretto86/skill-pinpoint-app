# frozen_string_literal: true

require "rails_helper"

RSpec.describe Users::SessionsController, type: :request do
  describe "GET #new" do
    it "returns http success" do
      get user_session_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    let(:user) { create(:user) }

    it "returns http success" do
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      expect(response).to have_http_status(:success)
    end
  end
end
