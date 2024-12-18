# frozen_string_literal: true

require "rails_helper"

RSpec.describe Survey::Question, type: :model do
  describe "Constants" do
    it "::QUESTION_KINDS" do
      expect(described_class::QUESTION_KINDS).to eq(%w[likert favorability nps])
    end
  end

  describe "Associations" do
    it "belongs_to survey" do
      association = described_class.reflect_on_association(:survey)
      expect(association.macro).to eq(:belongs_to)
    end

    it "has_many responses" do
      association = described_class.reflect_on_association(:responses)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:class_name]).to eq("Survey::Response")
    end
  end

  describe "Validations" do
    it "validates mandatory attributes" do
      question = described_class.new

      expect(question).to be_invalid
      expect(question.errors.count).to eq(3)
      expect(question.errors["survey"]).to eq(["must exist"])
      expect(question.errors["prompt"]).to eq(["can't be blank"])
      expect(question.errors["kind"]).to eq(["is not included in the list"])
    end
  end
end
