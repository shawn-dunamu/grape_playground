class CreateSurveys < ActiveRecord::Migration[5.2]
  def change
    create_table :surveys do |t|
      t.string  :uuid, null: false, index: {unique: true}
      t.string  :title, null: false
      t.text    :desc

      t.string  :aasm_state

      t.timestamps
    end
  end
end
