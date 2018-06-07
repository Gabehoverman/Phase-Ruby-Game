class AddIsanswerToQuestionAssets < ActiveRecord::Migration
  def change
    add_column :question_assets, :isanswer, :boolean
  end
end
