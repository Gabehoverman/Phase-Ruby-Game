class AddChapterIdToScores < ActiveRecord::Migration
  def change
    add_reference :scores, :chapter, index: true
  end
end
