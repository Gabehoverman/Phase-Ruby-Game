class AddFieldToResult < ActiveRecord::Migration
  def change
    add_reference :results, :asset, index: true
  end
end
