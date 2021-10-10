class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :title
      t.string :description
      t.references :rule, foreign_key: true
      t.references :component, foreign_key: true
      t.references :box, foreign_key: true

      t.timestamps
    end
  end
end
