# frozen_string_literal: true

class Survey::Participant < ApplicationRecord
  GENDER = %w[male female neutral not_informed].freeze

  belongs_to :survey, foreign_key: "survey_id", inverse_of: :participants

  has_many :responses, class_name: "Survey::Response", foreign_key: "survey_participant_id", dependent: :destroy

  enum gender: GENDER.index_by(&:itself)

  validates :gender, inclusion: { in: GENDER }
  validates :name, :email, :corporate_email, :department, :position, :function, :location, :company_tenure, :generation,
    :lv0_company, :lv1_directorate, :lv2_management, :lv3_coordination, :lv4_area,
    presence: true
end
