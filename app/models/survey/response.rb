# frozen_string_literal: true

class Survey::Response < ApplicationRecord
  belongs_to :participant, class_name: "Survey::Participant", foreign_key: "survey_participant_id", inverse_of: :responses
  belongs_to :question, class_name: "Survey::Question", foreign_key: "survey_question_id", inverse_of: :responses

  validates :answer, presence: true
  validate :answer_required_range

  after_create_commit :set_answered_at

  private
    def answer_required_range
      return if question.nil? || answer.nil?

      if question.nps?
        nps_answer_range
      elsif question.likert?
        likert_answer_range
      end
    end

    def nps_answer_range
      errors.add(:answer, "must be between 0 and 10") unless answer.match?(/^[0-9]$|^10$/)
    end

    def likert_answer_range
      errors.add(:answer, "must be between 1 and 5") unless answer.match?(/^[1-5]$/)
    end

    def set_answered_at
      self.answered_at ||= Time.current
    end
end

# == Schema Information
#
# Table name: survey_responses
#
#  id                    :bigint           not null, primary key
#  answer                :string           default(""), not null
#  answered_at           :datetime
#  comment               :text             default("")
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  survey_participant_id :bigint           not null
#  survey_question_id    :bigint           not null
#
# Indexes
#
#  index_survey_responses_on_survey_participant_id  (survey_participant_id)
#  index_survey_responses_on_survey_question_id     (survey_question_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_participant_id => survey_participants.id)
#  fk_rails_...  (survey_question_id => survey_questions.id)
#
