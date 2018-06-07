class AddEmailConfirmColumnToUsers < ActiveRecord::Migration
  def change
    add_column :instructors, :email_confirmed, :boolean, :default => false
    add_column :instructors, :confirm_token, :string
  end
end
