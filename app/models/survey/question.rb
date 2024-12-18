# frozen_string_literal: true

class Survey::Question < ApplicationRecord
  QUESTION_KINDS = %w[likert favorability nps].freeze

  belongs_to :survey, foreign_key: "survey_id", inverse_of: :questions

  has_many :responses, class_name: "Survey::Response", foreign_key: "survey_question_id", dependent: :destroy

  enum kind: QUESTION_KINDS.index_by(&:itself)

  validates :prompt, presence: true
  validates :kind, inclusion: { in: QUESTION_KINDS }
end
