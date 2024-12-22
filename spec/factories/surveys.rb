# frozen_string_literal: true

FactoryBot.define do
  factory :survey do
    sequence(:title) { |n| "Survey #{n}" }
    description { Faker::Lorem.sentence }
    status { "drafted" }
    start_date { Time.current + 1.day }
    end_date { Time.current + 8.days }

    trait :opened do
      after(:create) do |survey|
        survey.status = "opened"
        survey.start_date = Time.current - 1.day
        survey.end_date = Time.current + 7.days
        survey.save(validate: false)
      end
    end

    trait :with_poll_answered do
      after(:create) do |survey|
        create(:participant, survey: survey)
        create(:poll, :with_questions, survey: survey)
      end
    end
  end
end
