class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
     t.references :chapter
      t.string "question_desc"
      t.boolean "answer"

      t.timestamps null: false
    end
  end
end
