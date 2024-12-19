# frozen_string_literal: true

FactoryBot.define do
  factory :question, class: "Survey::Question" do
    sequence(:prompt) { |n| "Question #{n}?" }
    kind { "nps" }
    association(:poll)
  end
end
