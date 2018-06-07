class AddChapterRefToQuestionAssets < ActiveRecord::Migration
  def change
    add_reference :question_assets, :chapter, index: true, foreign_key: true
  end
end
