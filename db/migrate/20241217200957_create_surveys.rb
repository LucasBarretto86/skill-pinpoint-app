class CreateSurveys < ActiveRecord::Migration[7.1]
  def change
    create_table :surveys do |t|
      t.string :name, null: false, default: ""
      t.string :description, null: false, default: ""
      t.string :status, null: false, default: "drafted"
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false

      t.timestamps null: false
    end
  end
end
