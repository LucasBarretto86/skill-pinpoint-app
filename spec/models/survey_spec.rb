# frozen_string_literal: true

require "rails_helper"

RSpec.describe Survey, type: :model do
  describe "Constants" do
    it "::STATUS" do
      expect(described_class::STATUS).to eq(%w[drafted opened closed])
    end
  end

  describe "Associations" do
    it "has_many participants" do
      association = described_class.reflect_on_association(:participants)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:class_name]).to eq("Survey::Participant")
    end

    it "has_many questions" do
      association = described_class.reflect_on_association(:questions)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:class_name]).to eq("Survey::Question")
    end

    it "has_many responses" do
      association = described_class.reflect_on_association(:responses)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:through]).to eq(:questions)
    end
  end

  describe "Enums" do
    it ".statuses" do
      expect(described_class.statuses.keys).to eq(%w[drafted opened closed])
    end
  end

  describe "Validations" do
    it "validates mandatory fields" do
      survey = described_class.new(status: "")

      expect(survey).to be_invalid
      expect(survey.errors.count).to eq(5)
      expect(survey.errors["name"]).to eq(["can't be blank"])
      expect(survey.errors["description"]).to eq(["can't be blank"])
      expect(survey.errors["status"]).to eq(["is not included in the list"])
      expect(survey.errors["start_date"]).to eq(["can't be blank"])
      expect(survey.errors["end_date"]).to eq(["can't be blank"])
    end

    it "validates survey start data has to later than current day" do
      survey = build(:survey, start_date: Time.current)

      expect(survey).to be_invalid
      expect(survey.errors["start_date"]).to eq(["must be greater than current time"])
    end

    it "validates survey end data has to be later than start date" do
      start_date = Time.current
      survey = build(:survey, start_date: start_date, end_date: start_date)

      expect(survey).to be_invalid
      expect(survey.errors["end_date"]).to eq(["must be at least 1 hour greater than start date"])
    end
  end
end
