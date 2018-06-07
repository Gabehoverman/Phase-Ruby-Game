class IsAnswerCorrectToResults < ActiveRecord::Migration
  def change
  	    add_column :results, :isanswercorrect, :boolean

  end
end
