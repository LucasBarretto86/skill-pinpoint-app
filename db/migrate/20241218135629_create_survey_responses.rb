class CreateSurveyResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :survey_responses do |t|
      t.string :answer, null: false, default: ""
      t.text :comment, default: ""
      t.datetime :answered_at, null: true
      t.belongs_to :survey_question, null: false, foreign_key: true
      t.belongs_to :survey_participant, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
