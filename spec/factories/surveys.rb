# frozen_string_literal: true

FactoryBot.define do
  factory :survey do
    sequence(:title) { |n| "Survey #{n}" }
    description { Faker::Lorem.sentence }
    status { "drafted" }
    start_date { Date.current + 1.day }
    end_date { Date.current + 8.days }
  end
end
