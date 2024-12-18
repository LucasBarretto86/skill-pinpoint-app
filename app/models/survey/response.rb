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
