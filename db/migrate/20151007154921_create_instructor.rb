class CreateInstructor < ActiveRecord::Migration
  def change
    create_table :instructors do |t|
    	t.string "username", :limit => 25
    	t.string "email", :default => "", :null => false
    	t.string "password_digest"
    	t.timestamps null:false
    end
  end
end