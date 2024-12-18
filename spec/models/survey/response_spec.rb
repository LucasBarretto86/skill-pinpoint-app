# frozen_string_literal: true

require "rails_helper"

RSpec.describe Survey::Response, type: :model do
  describe "Associations" do
    it "belongs_to participant" do
      association = described_class.reflect_on_association(:participant)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:class_name]).to eq("Survey::Participant")
    end

    it "belongs_to question" do
      association = described_class.reflect_on_association(:question)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:class_name]).to eq("Survey::Question")
    end
  end

  describe "Validations" do
    it "validates mandatory attributes" do
      response = described_class.new

      expect(response).to be_invalid
      expect(response.errors.count).to eq(3)
      expect(response.errors["question"]).to eq(["must exist"])
      expect(response.errors["participant"]).to eq(["must exist"])
      expect(response.errors["answer"]).to eq(["can't be blank"])
    end

    context "when question is from nps kind" do
      let(:question) { create(:question, kind: "nps") }

      it "validates answer range" do
        response = build(:response, answer: "a", question: question)

        expect(response).to be_invalid
        expect(response.errors.count).to eq(1)
        expect(response.errors["answer"]).to eq(["must be between 0 and 10"])
      end
    end

    context "when question is from likert kind" do
      let(:question) { create(:question, kind: "likert") }

      it "validates answer range" do
        response = build(:response, answer: "a")

        expect(response).to be_invalid
        expect(response.errors.count).to eq(1)
        expect(response.errors["answer"]).to eq(["must be between 0 and 10"])
      end
    end
  end

  describe "Callbacks" do
    context "after_create_commit" do
      it "set_answered_at" do
        response = build(:response, :valid_answer)

        expect { response.save! }.to change { response.answered_at }.from(nil)
        expect(response.answered_at&.to_time).to be_instance_of(Time)
      end
    end
  end
end
