class AddEmailconfirmedToInstructors < ActiveRecord::Migration
  def change
    add_column :instructors, :emailconfirmed, :boolean, :default => false
  end
end
