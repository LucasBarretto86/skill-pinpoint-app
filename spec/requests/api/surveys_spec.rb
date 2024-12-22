# frozen_string_literal: true

require "rails_helper"

RSpec.describe API::SurveysController, type: :request do
  let!(:user) { create(:user) }

  before { authorize_user_by_token(user) }

  describe "GET #index" do
    before { create_list(:survey, 15) }
    context "when pagination params are submitted" do
      it "returns records paginated successfully" do
        get "/api/surveys?page=1&per_page=10"

        expect(response).to have_http_status(:success)
        expect(response_body["records"]).to be_a(Array)
        expect(response_body["records_count"]).to eq(15)
        expect(response_body["pages_count"]).to eq(2)
        expect(response_body["current_page"]).to eq(1)
      end
    end

    context "when request has no params" do
      it "returns records without pagination" do
        get "/api/surveys"

        expect(response).to have_http_status(:success)

        expect(response_body["surveys"]).to be_a(Array)
        expect(response_body["surveys"].count).to eq(15)
      end
    end
  end
end
