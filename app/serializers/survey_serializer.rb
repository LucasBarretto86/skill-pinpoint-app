# frozen_string_literal: true

class SurveySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :status, :start_date, :end_date

  has_many :participants
  has_many :polls
  has_many :questions
  has_many :responses
end
