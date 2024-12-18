class CreateSurveyQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :survey_questions do |t|
      t.text :prompt, null: false, default: ""
      t.string :kind, null: false, default: ""
      t.belongs_to :survey, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
