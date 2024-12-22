# frozen_string_literal: true

require "rails_helper"

RSpec.describe SurveySerializer, type: :serializer do
  let(:survey) { create(:survey, :opened, :with_poll_answered, title: "Test Survey", description: "A test survey description") }
  let(:serializer) { described_class.new(survey) }
  let(:serialized_hash) { serializer.serializable_hash }

  it "includes the expected attributes" do
    expect(serialized_hash[:id]).to eq(survey.id)
    expect(serialized_hash[:title]).to eq("Test Survey")
    expect(serialized_hash[:status]).to eq("opened")
    expect(serialized_hash[:description]).to eq("A test survey description")
    expect(serialized_hash).to have_key(:start_date)
    expect(serialized_hash).to have_key(:end_date)
    expect(serialized_hash).to have_key(:participants)
    expect(serialized_hash).to have_key(:polls)
    expect(serialized_hash).to have_key(:questions)
    expect(serialized_hash).to have_key(:responses)
  end

  it "does not include unwanted attributes" do
    expect(serialized_hash).not_to have_key(:created_at)
    expect(serialized_hash).not_to have_key(:updated_at)
  end
end
