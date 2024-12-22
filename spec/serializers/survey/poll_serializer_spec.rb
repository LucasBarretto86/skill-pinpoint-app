# frozen_string_literal: true

require "rails_helper"

RSpec.describe Survey::PollSerializer, type: :serializer do
  let(:poll) { create(:poll, :with_questions, title: "Test Poll", description: "A test poll description") }
  let(:serializer) { described_class.new(poll) }
  let(:serialized_hash) { serializer.serializable_hash }

  it "includes the expected attributes" do
    expect(serialized_hash[:id]).to eq(poll.id)
    expect(serialized_hash[:title]).to eq("Test Poll")
    expect(serialized_hash[:description]).to eq("A test poll description")
    expect(serialized_hash).to have_key(:survey)
    expect(serialized_hash).to have_key(:questions)
  end

  it "does not include unwanted attributes" do
    expect(serialized_hash).not_to have_key(:created_at)
    expect(serialized_hash).not_to have_key(:updated_at)
  end
end
