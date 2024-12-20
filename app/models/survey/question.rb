# frozen_string_literal: true

class Survey::Question < ApplicationRecord
  QUESTION_KINDS = %w[likert favorability nps].freeze

  belongs_to :poll, class_name: "Survey::Poll", foreign_key: "survey_poll_id", inverse_of: :questions

  has_many :responses, class_name: "Survey::Response", foreign_key: "survey_question_id", dependent: :destroy

  enum kind: QUESTION_KINDS.index_by(&:itself)

  validates :prompt, presence: true
  validates :kind, inclusion: { in: QUESTION_KINDS }
end

# == Schema Information
#
# Table name: survey_questions
#
#  id             :bigint           not null, primary key
#  kind           :string           default(NULL), not null
#  prompt         :text             default(""), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  survey_poll_id :bigint           not null
#
# Indexes
#
#  index_survey_questions_on_survey_poll_id  (survey_poll_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_poll_id => survey_polls.id)
#
