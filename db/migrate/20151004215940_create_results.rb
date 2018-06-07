class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
     t.references :student
      t.references :chapter
      t.boolean "ongoing", :default => true

      t.timestamps null: false
    end
     
  end
end
