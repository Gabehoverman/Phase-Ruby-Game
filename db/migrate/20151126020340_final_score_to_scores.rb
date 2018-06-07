class FinalScoreToScores < ActiveRecord::Migration
  def change
  	  	    add_column :scores, :final_score, :integer

  end
end
