# frozen_string_literal: true

require "rails_helper"

RSpec.describe API::HealthCheckController, type: :request do
  describe "GET #show" do
    it "returns http success" do
      get "/api/health-check"
      expect(response).to have_http_status(:success)
      expect(response_body).to eq({ "status" => "healthy" })
    end
  end
end
