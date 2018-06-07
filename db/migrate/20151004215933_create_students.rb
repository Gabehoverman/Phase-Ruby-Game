class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
    	 t.string "student_id", :limit => 8, :unique => true, :null => false
    	 t.boolean "active", :default => true 

      t.timestamps null: false
    end

    add_index("students", "student_id")
  end
end
