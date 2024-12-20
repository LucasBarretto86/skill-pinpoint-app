# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Users::Registrations", type: :request do
  describe "GET #new" do
    it "returns http success" do
      get new_user_registration_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    let(:valid_params) do
      { user: { email: Faker::Internet.email, password: "password", password_confirmation: "password" } }
    end

    let(:invalid_params) do
      { user: { email: Faker::Internet.email, password: "password", password_confirmation: "wrong_password" } }
    end

    it "returns http success" do
      post user_registration_path, params: valid_params
      expect(response).to have_http_status(:redirect)
    end

    it "returns http unprocessable entity" do
      post user_registration_path, params: invalid_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
