class AddPasswordResetToInstructors < ActiveRecord::Migration
  def change
    add_column :instructors, :password_reset_token, :string
    add_column :instructors, :password_reset_sent_at, :datetime
  end
end
