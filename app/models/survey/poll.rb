# frozen_string_literal: true

class Survey::Poll < ApplicationRecord
  belongs_to :survey, foreign_key: "survey_id", inverse_of: :polls

  has_many :questions, class_name: "Survey::Question", foreign_key: "survey_poll_id"
end

# == Schema Information
#
# Table name: survey_polls
#
#  id          :bigint           not null, primary key
#  description :text             default("")
#  title       :string           default("")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  survey_id   :bigint           not null
#
# Indexes
#
#  index_survey_polls_on_survey_id  (survey_id)
#
# Foreign Keys
#
#  fk_rails_...  (survey_id => surveys.id)
#
