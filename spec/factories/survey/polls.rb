# frozen_string_literal: true

FactoryBot.define do
  factory :poll, class: "Survey::Poll" do
    sequence(:title) { |n| "Survey Poll #{n}" }
    description { Faker::Lorem.sentence }
    association(:survey)
  end
end
