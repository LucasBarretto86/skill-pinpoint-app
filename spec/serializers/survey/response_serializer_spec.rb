# frozen_string_literal: true

require "rails_helper"

RSpec.describe Survey::ResponseSerializer, type: :serializer do
  let(:response) { create(:response, :valid_answer, answered_at: Time.current) }
  let(:serializer) { described_class.new(response) }
  let(:serialized_hash) { serializer.serializable_hash }

  it "includes the expected attributes" do
    expect(serialized_hash[:id]).to eq(response.id)
    expect(serialized_hash[:answer]).to eq("5")

    expect(serialized_hash).to have_key(:answered_at)
    expect(serialized_hash).to have_key(:participant)
    expect(serialized_hash).to have_key(:question)
  end

  it "does not include unwanted attributes" do
    expect(serialized_hash).not_to have_key(:created_at)
    expect(serialized_hash).not_to have_key(:updated_at)
  end
end
