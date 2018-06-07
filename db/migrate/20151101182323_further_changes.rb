class FurtherChanges < ActiveRecord::Migration
  def change
  	  	add_reference :results, :question, index: true, foreign_key: true
	    rename_column :questions, :answer, :correct_answer
  	    add_column :results, :student_answer, :boolean
  end
end
