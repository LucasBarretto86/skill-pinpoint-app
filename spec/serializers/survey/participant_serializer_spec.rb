# frozen_string_literal: true

require "rails_helper"

RSpec.describe Survey::ParticipantSerializer, type: :serializer do
  let!(:participant) { create(:participant) }
  let(:serializer) { described_class.new(participant) }
  let(:serializer_hash) { serializer.serializable_hash }

  it "includes the expected attributes" do
    expect(serializer_hash[:id]).to eq(participant.id)
    expect(serializer_hash[:name]).to eq(participant.name)
    expect(serializer_hash[:email]).to eq(participant.email)
    expect(serializer_hash[:corporate_email]).to eq(participant.corporate_email)
    expect(serializer_hash[:department]).to eq(participant.department)
    expect(serializer_hash[:position]).to eq("intern")
    expect(serializer_hash[:function]).to eq("professional")
    expect(serializer_hash[:location]).to eq("brasilia")
    expect(serializer_hash[:company_tenure]).to eq("Between 1 and 2 years")
    expect(serializer_hash[:gender]).to eq("male")
    expect(serializer_hash[:generation]).to eq("generation z")
    expect(serializer_hash[:lv0_company]).to eq("Company 1")
    expect(serializer_hash[:lv1_directorate]).to eq("Directorate 1")
    expect(serializer_hash[:lv2_management]).to eq("Management 1")
    expect(serializer_hash[:lv3_coordination]).to eq("Coordination 1")
    expect(serializer_hash[:lv4_area]).to eq("Area 1")
    expect(serializer_hash[:survey]).not_to eq(participant.survey)
  end

  it "does not include unwanted attributes" do
    expect(serializer.attributes).not_to include(:created_at)
    expect(serializer.attributes).not_to include(:updated_at)
  end
end
