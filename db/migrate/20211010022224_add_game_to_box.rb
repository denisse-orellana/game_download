class AddGameToBox < ActiveRecord::Migration[5.2]
  def change
    add_reference :boxes, :game, foreign_key: true
  end
end
