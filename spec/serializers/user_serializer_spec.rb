# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserSerializer, type: :serializer do
  let(:user) { create(:user, email: "example@example.com") }
  let(:serializer) { described_class.new(user) }
  let(:serialized_hash) { serializer.serializable_hash }

  it "includes the expected attributes" do
    expect(serialized_hash[:id]).to eq(user.id)
    expect(serialized_hash[:email]).to eq("example@example.com")
  end

  it "does not include unwanted attributes" do
    expect(serialized_hash).not_to have_key(:created_at)
    expect(serialized_hash).not_to have_key(:updated_at)
  end
end
