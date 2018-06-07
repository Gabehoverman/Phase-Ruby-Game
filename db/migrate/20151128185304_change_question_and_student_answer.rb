class ChangeQuestionAndStudentAnswer < ActiveRecord::Migration
  def up
  	change_column :questions, :correct_answer, :string
  	change_column :results, :student_answer, :string
  end

  def down
  	change_column :questions, :correct_answer, :boolean
  	change_column :results, :student_answer, :boolean
  end
end
