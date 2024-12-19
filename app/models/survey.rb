# frozen_string_literal: true

class Survey < ApplicationRecord
  STATUS = %w[drafted opened closed].freeze

  has_many :participants, class_name: "Survey::Participant", foreign_key: "survey_id"
  has_many :polls, class_name: "Survey::Poll", foreign_key: "survey_id"
  has_many :questions, class_name: "Survey::Question", through: :polls
  has_many :responses, class_name: "Survey::Response", through: :questions

  enum status: STATUS.index_by(&:itself)

  validates :title, :start_date, :end_date, :description, presence: true
  validates :status, inclusion: { in: STATUS }

  validate :start_date_greater_than_current_time, if: :start_date
  validate :end_date_at_least_one_hour_greater_than_start_date, if: :end_date

  private
    def start_date_greater_than_current_time
      unless start_date > Time.current
        errors.add(:start_date, "must be greater than current time")
      end
    end

    def end_date_at_least_one_hour_greater_than_start_date
      unless end_date >= (start_date + 1.hour)
        errors.add(:end_date, "must be at least 1 hour greater than start date")
      end
    end
end
