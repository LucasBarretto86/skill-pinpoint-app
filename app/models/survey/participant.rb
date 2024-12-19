# frozen_string_literal: true

class Survey::Participant < ApplicationRecord
  belongs_to :survey, foreign_key: "survey_id", inverse_of: :participants

  has_many :responses, class_name: "Survey::Response", foreign_key: "survey_participant_id"

  validates :name, :gender, :email, :corporate_email, :department, :position, :function, :location, :company_tenure, :generation,
    :lv0_company, :lv1_directorate, :lv2_management, :lv3_coordination, :lv4_area,
    presence: true
end

# == Schema Information
#
# Table name: survey_participants
#
#  id               :bigint           not null, primary key
#  company_tenure   :string           default(""), not null
#  corporate_email  :string           default(""), not null
#  department       :string           default(""), not null
#  email            :string           default(""), not null
#  function         :string           default(""), not null
#  gender           :string           default(""), not null
#  generation       :string           default(""), not null
#  location         :string           default(""), not null
#  lv0_company      :string           default(""), not null
#  lv1_directorate  :string           default(""), not null
#  lv2_management   :string           default(""), not null
#  lv3_coordination :string           default(""), not null
#  lv4_area         :string           default(""), not null
#  name             :string           default(""), not null
#  position         :string           default(""), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  survey_id        :bigint           not null
#
# Indexes
#
#  index_survey_participants_on_survey_id  (survey_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_id => surveys.id)
#
