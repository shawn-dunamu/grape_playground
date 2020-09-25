class CreateSurveyQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :survey_questions do |t|
      t.references :survey, foreign_key: true
      t.string :type
      t.string :title, null: false
      t.text :desc
      t.integer :order
      t.json :properties

      t.timestamps
    end
  end
end