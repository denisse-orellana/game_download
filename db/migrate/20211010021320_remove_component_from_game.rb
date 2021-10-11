class RemoveComponentFromGame < ActiveRecord::Migration[5.2]
  def change
    remove_reference :games, :component, foreign_key: true
  end
end
