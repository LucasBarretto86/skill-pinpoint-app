# frozen_string_literal: true

class Survey::PollSerializer < ActiveModel::Serializer
  attributes :id, :title, :description

  belongs_to :survey

  has_many :questions
end
