# frozen_string_literal: true

require "rails_helper"

RSpec.describe Survey::Poll, type: :model do
  describe "Associations" do
    it "belongs_to survey" do
      association = described_class.reflect_on_association(:survey)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:foreign_key]).to eq("survey_id")
    end

    it "has_many questions" do
      association = described_class.reflect_on_association(:questions)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:foreign_key]).to eq("survey_poll_id")
    end
  end

  describe "Validations" do
    it "validates mandatory attributes" do
      poll = described_class.new

      expect(poll).to be_invalid
      expect(poll.errors.count).to eq(1)
      expect(poll.errors["survey"]).to eq(["must exist"])
    end
  end
end
