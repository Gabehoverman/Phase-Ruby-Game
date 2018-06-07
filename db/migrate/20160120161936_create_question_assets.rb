class CreateQuestionAssets < ActiveRecord::Migration
  def change
    create_table :question_assets do |t|
      t.string :title
      t.string :image
      t.integer :bytes
      t.references :question
      t.timestamps
    end
  end
end
