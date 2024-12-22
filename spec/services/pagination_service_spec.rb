# frozen_string_literal: true

require "rails_helper"

RSpec.describe PaginationService, type: :service do
  let(:user) { create(:user) }
  let!(:surveys) { create_list(:survey, 25, :with_poll_answered) }
  let(:scope) { Survey.all }
  let(:page) { 1 }
  let(:per_page) { 10 }
  let(:serializer) { SurveySerializer }

  before { login_as(user, scope: :user) }

  describe "#paginate" do
    subject { PaginationService.new(scope, page: page, per_page: per_page, serializer: serializer) }

    context "when pagination is correct" do
      it "returns the correct number of records" do
        result = subject.paginate
        expect(result[:records].size).to eq(per_page)
      end

      it "calculates the correct pages_count" do
        result = subject.paginate
        expect(result[:pages_count]).to eq(3)
      end

      it "returns the correct current_page" do
        result = subject.paginate
        expect(result[:current_page]).to eq(1)
      end

      it "returns the correct records_count" do
        result = subject.paginate
        expect(result[:records_count]).to eq(25)
      end
    end

    context "when page number is invalid" do
      let(:page) { 0 }

      it "returns the first page" do
        result = subject.paginate
        expect(result[:current_page]).to eq(1)
      end
    end

    context "when serializer is provided" do
      let(:serializer) { double("UserSerializer") }
      let(:survey_serializer_instance) { double("Survey") }

      before do
        allow(serializer).to receive(:new).and_return(survey_serializer_instance)
        allow(survey_serializer_instance).to receive(:as_json).and_return({ id: 1, title: "Survey Test" })
      end

      it "serializes the records" do
        result = subject.paginate
        expect(result[:records].first).to eq(surveys.first)
      end
    end

    context "when serializer is not provided" do
      let(:serializer) { nil }

      it "does not serialize the records" do
        result = subject.paginate
        expect(result[:records].first).to be_a(Survey)
      end
    end
  end
end
