# frozen_string_literal: true

require "rails_helper"

RSpec.describe Authorization, type: :controller do
  controller(APIController) do

    def test_action
      render json: { message: "success" }, status: :ok
    end
  end

  let!(:user) { create(:user) }
  let(:secret_key) { "your_secret_key" }
  let(:valid_token) { JWT.encode(encode_payload(user), ENV["DEVISE_JWT_SECRET_KEY"]) }
  let(:invalid_token) { "invalid.token.payload" }
  let(:headers) { { "Authorization" => "Bearer #{valid_token}", "Content-Type" => "application/json" } }

  before do
    routes.draw { get "test_action" => "api#test_action" }
  end

  describe "before_action callbacks" do
    it "triggers authenticate_user_by_token!" do
      request.headers.merge!(headers)
      expect(controller).to receive(:authenticate_user_by_token!).and_call_original
      get :test_action, format: :json
    end
  end

  context "when token is valid" do
    it "sets the current user and returns success" do
      request.headers.merge!(headers)
      get :test_action, format: :json
      expect(response.status).to eq(200)
    end
  end

  context "when token is invalid" do
    it "returns an unauthorized error" do
      request.headers["Authorization"] = "Bearer #{invalid_token}"
      get :test_action, format: :json
      expect(response.status).to eq(401)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["error"]).to eq("Unauthorized: Invalid token")
    end
  end

  context "when user is not found" do
    it "returns user not found error" do
      invalid_payload_token = JWT.encode({ sub: 9999 }, ENV["DEVISE_JWT_SECRET_KEY"])
      request.headers["Authorization"] = "Bearer #{invalid_payload_token}"
      get :test_action, format: :json
      expect(response.status).to eq(401)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["error"]).to eq("Unauthorized: User not found")
    end
  end
end
