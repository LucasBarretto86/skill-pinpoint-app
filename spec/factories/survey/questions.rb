# frozen_string_literal: true

FactoryBot.define do
  factory :question, class: "Survey::Question" do
    sequence(:prompt) { |n| "Question #{n}?" }
    kind { "nps" }
    association(:poll)

    trait :with_responses do
      after(:create) do |question|
        participant = create(:participant, survey: question.poll.survey)
        create_list(:response, 10, :valid_answer, question: question, participant: participant)
      end
    end
  end
end
