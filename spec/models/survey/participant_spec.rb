# frozen_string_literal: true

require "rails_helper"

RSpec.describe Survey::Participant, type: :model do
  describe "Associations" do
    it "belongs_to survey" do
      association = described_class.reflect_on_association(:survey)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:foreign_key]).to eq("survey_id")
    end

    it "has_many responses" do
      association = described_class.reflect_on_association(:responses)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:class_name]).to eq("Survey::Response")
      expect(association.options[:foreign_key]).to eq("survey_participant_id")
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
      expect(participant.errors["gender"]).to eq(["can't be blank"])
      expect(participant.errors["generation"]).to eq(["can't be blank"])
      expect(participant.errors["lv0_company"]).to eq(["can't be blank"])
      expect(participant.errors["lv1_directorate"]).to eq(["can't be blank"])
      expect(participant.errors["lv2_management"]).to eq(["can't be blank"])
      expect(participant.errors["lv3_coordination"]).to eq(["can't be blank"])
      expect(participant.errors["lv4_area"]).to eq(["can't be blank"])
    end
  end
end
