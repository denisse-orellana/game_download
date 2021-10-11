class AddGameToComponent < ActiveRecord::Migration[5.2]
  def change
    add_reference :components, :game, foreign_key: true
  end
end
