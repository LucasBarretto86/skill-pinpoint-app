# frozen_string_literal: true

FactoryBot.define do
  factory :poll, class: "Survey::Poll" do
    sequence(:title) { |n| "Survey Poll #{n}" }
    description { Faker::Lorem.sentence }
    association(:survey)

    trait :with_questions do
      after(:create) do |poll|
        create_list(:question, 2, :with_responses, poll: poll)
      end
    end
  end
end
