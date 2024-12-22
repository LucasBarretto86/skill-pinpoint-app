# frozen_string_literal: true

class Survey::QuestionSerializer < ActiveModel::Serializer
  attributes :id, :prompt, :kind

  belongs_to :poll

  has_many :responses
end
