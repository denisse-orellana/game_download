class RemoveRuleFromGame < ActiveRecord::Migration[5.2]
  def change
    remove_reference :games, :rule, foreign_key: true
  end
end
