# frozen_string_literal: true

class Survey::ParticipantSerializer < ActiveModel::Serializer
  attributes :id, :name, :company_tenure, :corporate_email, :department, :email, :function, :gender, :generation, :location,
    :position, :lv0_company, :lv1_directorate, :lv2_management, :lv3_coordination, :lv4_area

  belongs_to :survey

  has_many :responses
end
