# frozen_string_literal: true

FactoryBot.define do
  factory :response, class: "Survey::Response" do
    answer { "5" }
    comment { Faker::Lorem.sentence }
    association(:question, factory: :question, strategy: :build)
    association(:participant, factory: :participant, strategy: :build)

    trait :valid_answer do
      after(:build) do |response|
        if response.question.nps?
          response.answer = "5"
        elsif response.question.likert?
          response.answer = "3"
        else
          response.answer = Faker::Quote.famous_last_words
        end
      end
    end
  end
end
