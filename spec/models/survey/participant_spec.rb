# frozen_string_literal: true

require "rails_helper"

RSpec.describe Survey::Participant, type: :model do
  describe "Constants" do
    it "::GENDER" do
      expect(described_class::GENDER).to eq(%w[male female neutral not_informed])
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
      expect(association.options[:dependent]).to eq(:destroy)
      expect(association.options[:class_name]).to eq("Survey::Response")
    end
  end

  describe "Enums" do
    it ".genders" do
      expect(described_class.genders.keys).to eq(%w[male female neutral not_informed])
    end
  end

  describe "Validations" do
    it "validates mandatory fields" do
      participant = described_class.new

      expect(participant).to be_invalid
      expect(participant.errors.count).to eq(16)
      expect(participant.errors["survey"]).to eq(["must exist"])
      expect(participant.errors["name"]).to eq(["can't be blank"])
      expect(participant.errors["email"]).to eq(["can't be blank"])
      expect(participant.errors["corporate_email"]).to eq(["can't be blank"])
      expect(participant.errors["department"]).to eq(["can't be blank"])
      expect(participant.errors["position"]).to eq(["can't be blank"])
      expect(participant.errors["function"]).to eq(["can't be blank"])
      expect(participant.errors["location"]).to eq(["can't be blank"])
      expect(participant.errors["company_tenure"]).to eq(["can't be blank"])
      expect(participant.errors["gender"]).to eq(["is not included in the list"])
      expect(participant.errors["generation"]).to eq(["can't be blank"])
      expect(participant.errors["lv0_company"]).to eq(["can't be blank"])
      expect(participant.errors["lv1_directorate"]).to eq(["can't be blank"])
      expect(participant.errors["lv2_management"]).to eq(["can't be blank"])
      expect(participant.errors["lv3_coordination"]).to eq(["can't be blank"])
      expect(participant.errors["lv4_area"]).to eq(["can't be blank"])
    end
  end
end
