# frozen_string_literal: true

require "rails_helper"

RSpec.describe Survey::QuestionSerializer, type: :serializer do
  let(:question) { create(:question, :with_responses, prompt: "Test question?", kind: "nps") }
  let(:serializer) { described_class.new(question) }
  let(:serialized_hash) { serializer.serializable_hash }

  it "includes the expected attributes" do
    expect(serialized_hash[:id]).to eq(question.id)
    expect(serialized_hash[:prompt]).to eq("Test question?")
    expect(serialized_hash[:kind]).to eq("nps")
    expect(serialized_hash).to have_key(:poll)
    expect(serialized_hash).to have_key(:responses)
  end

  it "does not include unwanted attributes" do
    expect(serialized_hash).not_to have_key(:created_at)
    expect(serialized_hash).not_to have_key(:updated_at)
  end
end
