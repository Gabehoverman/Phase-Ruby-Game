class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
     t.references :student, foreign_key: true
      t.references :results
      t.references :questions
      t.integer "is_value"
      t.integer "of_value"
      t.boolean "ongoing", :default => true
      t.timestamps null: false
    end
  end
end
