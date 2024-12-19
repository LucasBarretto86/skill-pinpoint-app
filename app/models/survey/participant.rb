# frozen_string_literal: true

class Survey::Participant < ApplicationRecord
  belongs_to :survey, foreign_key: "survey_id", inverse_of: :participants

  has_many :responses, class_name: "Survey::Response", foreign_key: "survey_participant_id"

  validates :name, :gender, :email, :corporate_email, :department, :position, :function, :location, :company_tenure, :generation,
    :lv0_company, :lv1_directorate, :lv2_management, :lv3_coordination, :lv4_area,
    presence: true
end
