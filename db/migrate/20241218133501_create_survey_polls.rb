class CreateSurveyPolls < ActiveRecord::Migration[7.1]
  def change
    create_table :survey_polls do |t|
      t.string :title, default: ""
      t.text :description, default: ""
      t.belongs_to :survey, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
