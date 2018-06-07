class AddQuestionamountToChapters < ActiveRecord::Migration
  def change
    add_column :chapters, :questionamount, :integer
  end
end
