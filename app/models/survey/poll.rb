# frozen_string_literal: true

class Survey::Poll < ApplicationRecord
  belongs_to :survey, foreign_key: "survey_id", inverse_of: :polls

  has_many :questions, class_name: "Survey::Question", foreign_key: "survey_poll_id"
end
