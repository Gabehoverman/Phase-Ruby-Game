class AddAuthTokenToInstructors < ActiveRecord::Migration
  def change
    add_column :instructors, :auth_token, :string
  end
end
