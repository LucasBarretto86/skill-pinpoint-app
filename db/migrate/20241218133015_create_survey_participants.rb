class CreateSurveyParticipants < ActiveRecord::Migration[7.1]
  def change
    create_table :survey_participants do |t|
      t.string :name, null: false, default: ""
      t.string :email, null: false, default: ""
      t.string :corporate_email, null: false, default: ""
      t.string :department, null: false, default: ""
      t.string :position, null: false, default: ""
      t.string :function, null: false, default: ""
      t.string :location, null: false, default: ""
      t.string :company_tenure, null: false, default: ""
      t.string :gender, null: false, default: ""
      t.string :generation, null: false, default: ""
      t.string :lv0_company, null: false, default: ""
      t.string :lv1_directorate, null: false, default: ""
      t.string :lv2_management, null: false, default: ""
      t.string :lv3_coordination, null: false, default: ""
      t.string :lv4_area, null: false, default: ""
      t.belongs_to :survey, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
