class AddScoreToResults < ActiveRecord::Migration
  def change
    add_reference :results, :score, index: true, foreign_key: true
  end
end
