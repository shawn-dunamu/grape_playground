class CreateOptionalQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :optional_questions do |t|
      t.references :survey_question, foreign_key: true

      t.string :question
      t.integer :order

      t.timestamps
    end
  end
end
