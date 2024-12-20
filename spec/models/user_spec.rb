# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "Validations" do
    it "validates mandatory attributes" do
      user = described_class.new

      expect(user).to be_invalid
      expect(user.errors.count).to eq(2)
      expect(user.errors["email"]).to eq(["can't be blank"])
      expect(user.errors["password"]).to eq(["can't be blank"])
    end

    it "validates email format" do
      user = build(:user, email: "123@")

      expect(user).to be_invalid
      expect(user.errors.count).to eq(1)
      expect(user.errors["email"]).to eq(["is invalid"])
    end

    it "validates email uniqueness" do
      user = create(:user)

      new_user = build(:user, email: user.email)
      expect(new_user).to be_invalid
      expect(new_user.errors.count).to eq(1)
      expect(new_user.errors["email"]).to eq(["has already been taken"])
    end

    it "validates password minimum length" do
      user = build(:user, password: "123")

      expect(user).to be_invalid
      expect(user.errors.count).to eq(1)
      expect(user.errors["password"]).to eq(["is too short (minimum is 8 characters)"])
    end

    it "validates password maximum length" do
      user = build(:user, password: "1" * 17)

      expect(user).to be_invalid
      expect(user.errors.count).to eq(1)
      expect(user.errors["password"]).to eq(["is too long (maximum is 16 characters)"])
    end

    it "validates password confirmation" do
      user = build(:user, password: "123456789", password_confirmation: "9999999999")
      expect(user).to be_invalid
      expect(user.errors.count).to eq(1)
      expect(user.errors["password_confirmation"]).to eq(["doesn't match Password"])
    end
  end
end
