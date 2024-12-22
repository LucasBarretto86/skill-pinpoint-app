# frozen_string_literal: true

class Survey::ResponseSerializer < ActiveModel::Serializer
  attributes :id, :answer, :answered_at

  belongs_to :participant
  belongs_to :question
end
