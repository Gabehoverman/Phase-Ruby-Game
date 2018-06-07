class AddInstructorRefToStudents < ActiveRecord::Migration
  def change
    add_reference :students, :instructor, index: true, foreign_key: true
  end
end
