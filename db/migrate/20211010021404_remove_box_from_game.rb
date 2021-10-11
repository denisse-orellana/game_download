class RemoveBoxFromGame < ActiveRecord::Migration[5.2]
  def change
    remove_reference :games, :box, foreign_key: true
  end
end
