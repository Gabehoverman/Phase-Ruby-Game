class AddChapterNumberToChapters < ActiveRecord::Migration
  def change
  	 add_column :chapters, :chapter_number, :integer

  end
end
